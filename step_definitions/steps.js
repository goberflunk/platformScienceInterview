const {
    Given, When, Then, And, Before
} = require('@cucumber/cucumber');
const utilities = require('./utilities/utilities')

var world = require('./utilities/world');
const expect = require('chai').expect;

const url = "http://localhost:8080/v1/cleaning-sessions";

Before(function () {
    world.request = {};
    world.response = {};
});

Given(/^I have a room of size (.*) (.*)$/, async function (x, y) {
    world.request.roomSize = [x, y];
});

Given(/^I start at coords (.*) (.*)$/, async function (x, y) {
    world.request.coords = [x, y];
});

Given(/^The patches are at$/, async function (data) {
    world.request.patches = data.raw();
});

Given(/^my instruction set is (.*)$/, async function (instructions) {
    world.request.instructions = instructions;
});

When(/^I submit to the endpoint$/, async function () {
    world.response = await utilities.post(url, world.request);
});

Then(/^The response has status code (.*)$/, async function (responseCode) {
    expect(world.response.status).to.equal(parseInt(responseCode));
});

Then(/^The response contains coords (.*) (.*)$/, async function (x, y) {
    expect(world.response.data.coords).to.deep.equal([parseInt(x), parseInt(y)]);
})

Then(/^The response contains (.*) patches$/, async function (patches) {
    expect(world.response.data.patches).to.equal(parseInt(patches));
});