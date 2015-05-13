nobone = require 'nobone'
{ kit } = nobone
{ _, Promise } = kit

module.exports = (task, option) ->
    randName = 'toys/' + Date.now()
    option '-n, --name <Timestamp>', 'toy folder name', randName

    option '--port <8112>', 'server port', 8013

    task 'default', (opts) ->
        { service, renderer } = nobone()
        kit.copy 'template', opts.name
        .then ->
            service.use renderer.static opts.name

            service.listen opts.port, ->
                kit.log 'Listen at ' + opts.port

                kit.spawn 'subl', [opts.name]
                kit.xopen "http://127.0.0.1:#{opts.port}/index.html"

    task 'lab l', (opts) ->
        