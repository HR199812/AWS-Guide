var https = require("https");
let axios = require("axios");
let Route = require("./route.json");

// Handler Function 
exports.handler = async (event, context, callback) => {
  try {
    console.log('event', event);
    callback(null, "Success");
  } catch (e) {
    console.log("Exception : ", e);
    callback(null, "Success");
  }
};
