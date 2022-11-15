const axios = require('axios');

async function post(url, payload) {
    return await axios.post(url, payload)
        .then(function (response) {
            return response;
        })
        .catch(function (error) {
            return error.response;
        });
}

exports.post = post;