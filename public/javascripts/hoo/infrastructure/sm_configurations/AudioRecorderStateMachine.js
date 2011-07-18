/* DO NOT MODIFY. This file was compiled Fri, 15 Jul 2011 10:47:42 GMT from
 * /Users/shooley/Desktop/Organ/Programming/Ruby/javascriptstuff/app/coffeescripts/hoo/infrastructure/sm_configurations/AudioRecorderStateMachine.coffee
 */

(function() {
  ABoo.AudioRecorderStateMachine = ABoo.AbstractConfiguration.extend({
    sm_config: function() {
      var AudioRecorderStateMachine_config;
      AudioRecorderStateMachine_config = {
        "states": ["st_disabled", "st_enabled", ["st_active1", "st_enabled"]],
        "events": ["showMonitoring", "ev_error", "ev_disable"],
        "commands": ["cmd_showMonitoring"],
        "transitions": [
          {
            "state": "st_disabled",
            "event": "showMonitoring",
            "nextState": "st_active1"
          }
        ],
        "actions": [
          {
            "state": "st_active1",
            "entryAction": "cmd_showMonitoring",
            "exitAction": null
          }
        ],
        "resetEvents": ["ev_disable", "ev_error"]
      };
      return AudioRecorderStateMachine_config;
    }
  });
}).call(this);
