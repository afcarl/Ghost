FROM dockerimages/docker-nave:latest
# ADD . /ghost2
RUN git clone https://github.com/TryGhost/Ghost.git
WORKDIR /Ghost
RUN nave use stable npm install -g grunt-cli \
 && nave use stable npm install \
 && nave use stable grunt init \
 && nave use stable grunt prod
RUN echo '// # Ghost Configuration \n\
// Setup your Ghost install for various environments \n\
// Documentation can be found at http://support.ghost.org/config/ \n\
\n\
var path = require("path"),\n\
    config;\n\
\n\
var os = require("os");\n\
\n\
config = {\n\
    // ### Production\n\
    // When running Ghost in the wild, use the production environment\n\
    // Configure your URL and mail settings here\n\
    production: {\n\
        url: "http://" + os.hostname(),\n\
        mail: {},\n\
        database: {\n\
            client: "sqlite3",\n\
            connection: {\n\
                filename: path.join(__dirname, "/content/data/ghost.db")\n\
            },\n\
            debug: false\n\
        },\n\' > config.js
RUN echo '\n\
        server: {\n\
            // Host to be passed to node's \`net.Server#listen()\`\n\
            host: "0.0.0.0",\n\
            // Port to be passed to node's \`net.Server#listen()\`, for iisnode set this to \`process.env.PORT\`\n\
            port: "80"\n\
        }\n\
    }\n\
};\n\
\n\
// Export config\n\
module.exports = config;' >> config.js
CMD nave use stable npm start
