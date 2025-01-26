// index.js
exports.handler = async (event) => {
    console.log('LOG_LEVEL:', process.env.LOG_LEVEL);  // Will log "info"
    return {
        statusCode: 200,
        body: JSON.stringify('Hello from Lambda!'),
    };
};
