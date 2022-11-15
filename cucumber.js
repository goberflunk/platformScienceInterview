const tags = process.env.TAG
var common;
if (tags)
    common = `features/ --publish-quiet --require step_definitions --format progress --tags "${tags.replace(/['"]+/g, '')}"`;
else
    common = `features/ --publish-quiet --require step_definitions --format progress`;


module.exports = {
    default: `${common}`
}