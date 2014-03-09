
SceneManager = require './scenemanager.coffee'
Helpers = require './helpers.coffee'
Timer = require './timer.coffee'

class Game

    @addScene: (scene) ->
        @sceneManager ?= new SceneManager()
        @sceneManager.addScene scene

    constructor: (params) ->

        @params = Helpers.extend {
            "width" : 800,
            "height": 600
        }, params

        canvas = document.createElement 'canvas'
        canvas.setAttribute "width", @params.width
        canvas.setAttribute "height", @params.height
        document.querySelector("body").appendChild(canvas)

        @ctx = canvas.getContext('2d')
        @ctx.font = '400 18px Helvetica, sans-serif'

        # TODO: remove Timer as necessary ingredient. Use the timestamp parameter to requestAnimationFrame instead.
        @timer = new Timer

        # the instance's scenemanager points to the Classes Scenemanager
        # (or, if it doesn't exist, a newly instantiated one)
        @sceneManager = @constructor.sceneManager || new SceneManager()

    gameloop: (timestamp) =>
        @update()
        @render()
        @loopID = window.requestAnimationFrame @gameloop if @loopID

    start: ->
        @loopID = window.requestAnimationFrame @gameloop

    stop: ->
        cancelAnimationFrame @loopID
        @loopID = undefined

    update: ->
        @timer.punch()

    render: ->
        @ctx.clearRect 0, 0, @params.width, @params.height

module.exports = Game
