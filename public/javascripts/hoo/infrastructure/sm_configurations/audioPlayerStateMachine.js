/* DO NOT MODIFY. This file was compiled Tue, 05 Jul 2011 10:14:20 GMT from
 * /Users/shooley/Desktop/Organ/Programming/Ruby/javascriptstuff/app/coffeescripts/hoo/infrastructure/sm_configurations/audioPlayerStateMachine.coffee
 */

(function() {
  ABoo.AudioPlayerStateMachine = SC.Object.extend({
    _loadingController: void 0,
    _playingController: void 0,
    _controller: void 0,
    init: function() {
      var loadingStateMachine, loadingStateMachineParser, playingStateMachine, playingStateMachineParser;
      this._super();
      loadingStateMachineParser = ABoo.HooStateMachineConfigurator.create({
        _config: ABoo.AudioPlayerStateMachine.loadingStateMachine_config
      });
      loadingStateMachine = ABoo.HooStateMachine.create({
        _startState: loadingStateMachineParser.state("st_empty")
      });
      this._loadingController = ABoo.HooStateMachine_controller.create({
        _currentState: loadingStateMachineParser.state("st_empty"),
        _machine: loadingStateMachine,
        _commandsChannel: this
      });
      playingStateMachineParser = ABoo.HooStateMachineConfigurator.create({
        _config: ABoo.AudioPlayerStateMachine.playingStateMachine_config
      });
      playingStateMachine = ABoo.HooStateMachine.create({
        _startState: playingStateMachineParser.state("st_empty")
      });
      return this._playingController = ABoo.HooStateMachine_controller.create({
        _currentState: playingStateMachineParser.state("st_empty"),
        _machine: playingStateMachine,
        _commandsChannel: this
      });
    },
    send: function(command) {
      var func;
      func = this._controller[command._name];
      if (func) {
        func.call(this._controller);
      } else {
        console.log("Didnt find function " + command._name);
      }
      if (command._name === "cmd_showResettingLoader") {
        return this._loadingController.handle("ev_resetComplete");
      }
    },
    processInputSignal: function(signal) {
      switch (signal) {
        case "ready":
          return this._controller.ready();
        case "abort":
          return 0;
        case "error":
        case "dataunavailable":
        case "empty":
          this._loadingController.handle("ev_error");
          return this._playingController.handle("ev_error");
        case "stalled":
          return this._loadingController.handle("ev_stall");
        case "waiting":
          return this._playingController.handle("ev_wait");
        case "loadstart":
        case "loadedmetadata":
          return this._loadingController.handle("ev_load");
        case "durationchange":
          this._loadingController.handle("ev_load");
          return this._controller.durationchange();
        case "progress":
          this._loadingController.handle("ev_load");
          return this._controller.progressupdate();
        case "canplay":
        case "canplaythrough":
          this._loadingController.handle("ev_load");
          return this._playingController.handle("ev_canPlay");
        case "emptied":
          this._loadingController.handle("ev_reset");
          return this._playingController.handle("ev_reset");
        case "timeupdate":
          this._playingController.handle("ev_timeupdate");
          return this._controller.timeupdate();
        case "play":
          return this._playingController.handle("ev_play");
        case "ended":
          return this._playingController.handle("ev_ended");
        case "pause":
          return this._playingController.handle("ev_stop");
        default:
          throw "** Unknown Signal ** -" + signal;
      }
    }
  });
  ABoo.AudioPlayerStateMachineClassMethods = SC.Mixin.create({
    loadingStateMachine_config: {
      "states": ["st_empty", "st_stalled", "st_loading", "st_resetting", "st_error"],
      "events": ["ev_error", "ev_reset", "ev_load", "ev_resetComplete", "ev_stall"],
      "commands": ["cmd_showEmptyLoader", "cmd_showStalledLoader", "cmd_showLoadingLoader", "cmd_showResettingLoader", "cmd_showErrorLoader"],
      "transitions": [
        {
          "state": "st_empty",
          "event": "ev_load",
          "nextState": "st_loading"
        }, {
          "state": "st_loading",
          "event": "ev_stall",
          "nextState": "st_stalled"
        }, {
          "state": "st_loading",
          "event": "ev_error",
          "nextState": "st_error"
        }, {
          "state": "st_loading",
          "event": "ev_reset",
          "nextState": "st_resetting"
        }, {
          "state": "st_stalled",
          "event": "ev_load",
          "nextState": "st_loading"
        }, {
          "state": "st_stalled",
          "event": "ev_error",
          "nextState": "st_error"
        }, {
          "state": "st_stalled",
          "event": "ev_reset",
          "nextState": "st_resetting"
        }, {
          "state": "st_empty",
          "event": "ev_reset",
          "nextState": "st_resetting"
        }, {
          "state": "st_error",
          "event": "ev_reset",
          "nextState": "st_resetting"
        }, {
          "state": "st_resetting",
          "event": "ev_resetComplete",
          "nextState": "st_empty"
        }
      ],
      "actions": [
        {
          "state": "st_empty",
          "entryAction": "cmd_showEmptyLoader",
          "exitAction": null
        }, {
          "state": "st_stalled",
          "entryAction": "cmd_showStalledLoader",
          "exitAction": null
        }, {
          "state": "st_loading",
          "entryAction": "cmd_showLoadingLoader",
          "exitAction": null
        }, {
          "state": "st_resetting",
          "entryAction": "cmd_showResettingLoader",
          "exitAction": null
        }, {
          "state": "st_error",
          "entryAction": "cmd_showErrorLoader",
          "exitAction": null
        }
      ],
      "resetEvents": []
    },
    playingStateMachine_config: {
      "states": ["st_empty", "st_stopped", "st_waiting", "st_playing", "st_finished", "st_error"],
      "events": ["ev_canPlay", "ev_play", "ev_timeupdate", "ev_wait", "ev_stop", "ev_ended", "ev_error", "ev_reset"],
      "commands": ["cmd_showEmptyPlayer", "cmd_showStoppedPlayer", "cmd_showWaitingPlayer", "cmd_hideWaitingPlayer", "cmd_showPlayingPlayer", "cmd_showFinishedPlayer", "cmd_showErrorPlayer"],
      "transitions": [
        {
          "state": "st_empty",
          "event": "ev_canPlay",
          "nextState": "st_stopped"
        }, {
          "state": "st_empty",
          "event": "ev_error",
          "nextState": "st_error"
        }, {
          "state": "st_empty",
          "event": "ev_play",
          "nextState": "st_playing"
        }, {
          "state": "st_stopped",
          "event": "ev_play",
          "nextState": "st_playing"
        }, {
          "state": "st_stopped",
          "event": "ev_error",
          "nextState": "st_error"
        }, {
          "state": "st_stopped",
          "event": "ev_reset",
          "nextState": "st_empty"
        }, {
          "state": "st_playing",
          "event": "ev_error",
          "nextState": "st_error"
        }, {
          "state": "st_playing",
          "event": "ev_stop",
          "nextState": "st_stopped"
        }, {
          "state": "st_playing",
          "event": "ev_reset",
          "nextState": "st_empty"
        }, {
          "state": "st_playing",
          "event": "ev_wait",
          "nextState": "st_waiting"
        }, {
          "state": "st_playing",
          "event": "ev_ended",
          "nextState": "st_finished"
        }, {
          "state": "st_waiting",
          "event": "ev_error",
          "nextState": "st_error"
        }, {
          "state": "st_waiting",
          "event": "ev_stop",
          "nextState": "st_stopped"
        }, {
          "state": "st_waiting",
          "event": "ev_timeupdate",
          "nextState": "st_playing"
        }, {
          "state": "st_waiting",
          "event": "ev_reset",
          "nextState": "st_empty"
        }, {
          "state": "st_finished",
          "event": "ev_stop",
          "nextState": "st_stopped"
        }, {
          "state": "st_error",
          "event": "ev_reset",
          "nextState": "st_empty"
        }
      ],
      "actions": [
        {
          "state": "st_empty",
          "entryAction": "cmd_showEmptyPlayer",
          "exitAction": null
        }, {
          "state": "st_stopped",
          "entryAction": "cmd_showStoppedPlayer",
          "exitAction": null
        }, {
          "state": "st_waiting",
          "entryAction": "cmd_showWaitingPlayer",
          "exitAction": "cmd_hideWaitingPlayer"
        }, {
          "state": "st_playing",
          "entryAction": "cmd_showPlayingPlayer",
          "exitAction": null
        }, {
          "state": "st_finished",
          "entryAction": "cmd_showFinishedPlayer",
          "exitAction": null
        }, {
          "state": "st_error",
          "entryAction": "cmd_showErrorPlayer",
          "exitAction": null
        }
      ],
      "resetEvents": []
    }
  });
  SC.mixin(ABoo.AudioPlayerStateMachine, ABoo.AudioPlayerStateMachineClassMethods);
}).call(this);
