/* DO NOT MODIFY. This file was compiled Tue, 07 Jun 2011 12:37:08 GMT from
 * /Users/shooley/Desktop/Organ/Programming/Ruby/javascriptstuff/app/coffeescripts/hoo/infrastructure/sm_configurations/abstractConfiguration.coffee
 */

(function() {
  ABoo.AbstractConfiguration = SC.Object.extend({
    _stateMachineController: void 0,
    _controller: void 0,
    init: function() {
      this._super();
      return this.setupStateMachines();
    },
    setupStateMachines: function() {
      var startState, stateMachineInstance, stateMachineParser, stateMachine_config;
      stateMachine_config = this.sm_config();
      stateMachineParser = ABoo.HooStateMachineConfigurator.create({
        _config: stateMachine_config
      });
      startState = stateMachineParser.state(stateMachine_config['states'][0]);
      stateMachineInstance = ABoo.HooStateMachine.create({
        _startState: startState,
        _resetEvents: stateMachineParser._resetEvents
      });
      return this._stateMachineController = ABoo.HooStateMachine_controller.create({
        _currentState: startState,
        _machine: stateMachineInstance,
        _commandsChannel: this
      });
    },
    processInputSignal: function(signal) {
      return this._stateMachineController.handle(signal);
    },
    send: function(command) {
      var func;
      func = this._controller[command._name];
      if (func != null) {
        return func.call(this._controller);
      } else {
        return console.warn("Didnt find function " + command._name);
      }
    },
    sm_config: function() {
      debugger;      return null;
    },
    currentStateName: function() {
      return this._stateMachineController._currentState._name;
    }
  });
}).call(this);
