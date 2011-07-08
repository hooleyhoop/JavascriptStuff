/* DO NOT MODIFY. This file was compiled Thu, 07 Jul 2011 11:41:21 GMT from
 * /Users/shooley/Desktop/Organ/Programming/Ruby/javascriptstuff/app/coffeescripts/hoo/infrastructure/simple-state-machine.coffee
 */

(function() {
  /*
  */  ABoo.HooStateMachine_command = SC.Object.extend({
    _name: void 0
  });
  /*
  */
  ABoo.HooStateMachine_event = SC.Object.extend({
    _name: void 0
  });
  /*
  */
  ABoo.HooStateMachine_state = SC.Object.extend({
    _name: void 0,
    _entryActions: void 0,
    _exitActions: void 0,
    _transitions: void 0,
    _parent: void 0,
    init: function() {
      this._super();
      this._entryActions = new Array();
      this._exitActions = new Array();
      return this._transitions = new Object();
    },
    addTransition: function(event, targetState) {
      var t;
      if (!((targetState != null) && (event != null))) {
        alert("Error: invalid params for HooStateMachine_state");
      }
      t = ABoo.HooStateMachine_transition.create({
        _source: this,
        _trigger: event,
        _target: targetState
      });
      return this._transitions[event._name] = t;
    },
    removeAllTransitions: function() {
      return this._transitions = new Object();
    },
    addEntryAction: function(cmd) {
      return this._entryActions.push(cmd);
    },
    addExitAction: function(cmd) {
      return this._exitActions.push(cmd);
    },
    hasTransition: function(eventName) {
      var hasT;
      hasT = this._transitions.hasOwnProperty(eventName);
      if (hasT === false && (this._parent != null)) {
        hasT = this._parent.hasTransition(eventName);
      }
      return hasT;
    },
    transitionForEvent: function(eventName) {
      var transition;
      transition = this._transitions[eventName];
      if (!(transition != null) && (this._parent != null)) {
        transition = this._parent.transitionForEvent(eventName);
      }
      return transition;
    },
    targetState: function(eventName) {
      var tState, transition;
      transition = this.transitionForEvent(eventName);
      tState = transition._target;
      return tState;
    },
    executeEntryActions: function(commandsChannel) {
      var value, _i, _len, _ref;
      _ref = this._entryActions;
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        value = _ref[_i];
        commandsChannel.send(value);
      }
      return true;
    },
    executeExitActions: function(commandsChannel) {
      var value, _i, _len, _ref;
      _ref = this._exitActions;
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        value = _ref[_i];
        commandsChannel.send(value);
      }
      return true;
    },
    hierachyList: function() {
      var head, hierachy;
      hierachy = new Array();
      head = this;
      while ((head != null)) {
        hierachy.unshift(head);
        head = head._parent;
      }
      return hierachy;
    }
  });
  /*
  	Transition
  */
  ABoo.HooStateMachine_transition = SC.Object.extend({
    _source: void 0,
    _trigger: void 0,
    _target: void 0,
    getEventName: function() {
      return this._trigger._name;
    }
  });
  /*
  	HooStateMachineConfigurator
  */
  ABoo.HooStateMachineConfigurator = SC.Object.extend({
    _config: void 0,
    _states: void 0,
    _events: void 0,
    _commands: void 0,
    _resetEvents: void 0,
    init: function() {
      this._super();
      this._states = new Object;
      this._events = new Object;
      this._commands = new Object;
      this._resetEvents = new Array();
      this.parseStates();
      this.parseEvents();
      this.parseCommands();
      this.parseTransitions();
      this.parseActions();
      return this.parseResetEvents();
    },
    parseStates: function() {
      var newState, parentState, parentStateName, stateName, value, _i, _len, _ref, _results;
      _ref = this._config['states'];
      _results = [];
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        value = _ref[_i];
        stateName = value;
        parentState = null;
        if ($.isArray(value)) {
          stateName = value[0];
          parentStateName = value[1];
          parentState = this._states[parentStateName];
          if (parentState == null) {
            alert("Error: Parent state doesnt exist");
          }
        }
        newState = ABoo.HooStateMachine_state.create({
          _name: stateName,
          _parent: parentState
        });
        _results.push(this._states[stateName] = newState);
      }
      return _results;
    },
    parseEvents: function() {
      var newEvent, value, _i, _len, _ref, _results;
      _ref = this._config['events'];
      _results = [];
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        value = _ref[_i];
        newEvent = ABoo.HooStateMachine_event.create({
          _name: value
        });
        _results.push(this._events[value] = newEvent);
      }
      return _results;
    },
    parseResetEvents: function() {
      var ev, value, _i, _len, _ref, _results;
      _ref = this._config['resetEvents'];
      _results = [];
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        value = _ref[_i];
        ev = this._events[value];
        if (!ev) {
          alert("Error! is reset event a real event?");
        }
        _results.push(this._resetEvents.push(ev));
      }
      return _results;
    },
    parseCommands: function() {
      var newCommand, value, _i, _len, _ref, _results;
      _ref = this._config['commands'];
      _results = [];
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        value = _ref[_i];
        newCommand = ABoo.HooStateMachine_command.create({
          _name: value
        });
        _results.push(this._commands[value] = newCommand);
      }
      return _results;
    },
    parseTransitions: function() {
      var eventName, nextStateName, stateName, value, _i, _len, _ref, _results;
      _ref = this._config['transitions'];
      _results = [];
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        value = _ref[_i];
        stateName = value['state'];
        eventName = value['event'];
        nextStateName = value['nextState'];
        _results.push(this._states[stateName].addTransition(this._events[eventName], this._states[nextStateName]));
      }
      return _results;
    },
    parseActions: function() {
      var entryAction, entryCmd, exitAction, exitCmd, state, stateName, value, _i, _len, _ref, _results;
      _ref = this._config['actions'];
      _results = [];
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        value = _ref[_i];
        if (!(value != null)) {
          return;
        }
        stateName = value['state'];
        entryAction = value['entryAction'];
        exitAction = value['exitAction'];
        state = this._states[stateName];
        if (entryAction != null) {
          entryCmd = this._commands[entryAction];
          state.addEntryAction(entryCmd);
        }
        _results.push(exitAction != null ? (exitCmd = this._commands[exitAction], state.addExitAction(exitCmd)) : void 0);
      }
      return _results;
    },
    state: function(key) {
      return this._states[key];
    }
  });
  /*
  	HooStateMachine
  */
  ABoo.HooStateMachine = SC.Object.extend({
    _startState: void 0,
    _resetEvents: void 0,
    init: function() {
      this._super();
      return this._resetEvents || (this._resetEvents = new Array());
    },
    addResetEvents: function(events) {
      var value, _i, _len;
      for (_i = 0, _len = events.length; _i < _len; _i++) {
        value = events[_i];
        this._resetEvents.push(value);
      }
      return true;
    },
    isResetEvent: function(eventName) {
      var resetEventNames, result;
      resetEventNames = this.resetEventNames();
      result = $.inArray(eventName, resetEventNames);
      return result > -1;
    },
    resetEventNames: function() {
      var event, eventNames;
      return eventNames = (function() {
        var _i, _len, _ref, _results;
        _ref = this._resetEvents;
        _results = [];
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          event = _ref[_i];
          _results.push(event._name);
        }
        return _results;
      }).call(this);
    }
  });
  /*
   * Communicates with devices by receiving event messages and sending command messages.
   * These are both four-letter codes sent through the communication channels.
  */
  ABoo.HooStateMachine_controller = SC.Object.extend({
    _currentState: void 0,
    _machine: void 0,
    _commandsChannel: void 0,
    handle: function(eventName, e, f) {
      var nextState;
      nextState = null;
      if (e != null) {
        this._commandsChannel.lastWindowEvent = e;
      }
      if (this._currentState.hasTransition(eventName)) {
        nextState = this._currentState.targetState(eventName);
      } else if (this._machine.isResetEvent(eventName)) {
        console.log("Found reset event");
        nextState = this._machine._startState;
      } else {
        console.log("** Unknown event " + eventName + " for state: " + this._currentState._name);
      }
      if (nextState != null) {
        return this._transitionTo(nextState);
      }
    },
    _transitionTo: function(targetState) {
      var element, i, sharedparentsIndex, shortestLength, thatParentList, thisParentList, _i, _j, _len, _len2;
      thisParentList = this._currentState.hierachyList();
      thatParentList = targetState.hierachyList();
      shortestLength = thisParentList.length < thatParentList.length ? thisParentList.length : thatParentList.length;
      sharedparentsIndex = -1;
      i = 0;
      while (i < shortestLength) {
        if (thisParentList[i] === thatParentList[i]) {
          sharedparentsIndex = i++;
        } else {
          break;
        }
      }
      if (sharedparentsIndex > -1) {
        thisParentList.splice(0, sharedparentsIndex + 1);
        thatParentList.splice(0, sharedparentsIndex + 1);
      }
      thisParentList.reverse();
      for (_i = 0, _len = thisParentList.length; _i < _len; _i++) {
        element = thisParentList[_i];
        element.executeExitActions(this._commandsChannel);
      }
      this._currentState = targetState;
      for (_j = 0, _len2 = thatParentList.length; _j < _len2; _j++) {
        element = thatParentList[_j];
        element.executeEntryActions(this._commandsChannel);
      }
      return true;
    }
  });
}).call(this);
