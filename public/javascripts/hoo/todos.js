/* DO NOT MODIFY. This file was compiled Thu, 02 Jun 2011 10:31:40 GMT from
 * /Users/shooley/Desktop/Organ/Programming/Ruby/javascriptstuff/app/coffeescripts/hoo/todos.coffee
 */

(function() {
  var Todos;
  Todos = SC.Application.create();
  Todos.Todo = SC.Object.extend({
    title: null,
    isDone: false
  });
  Todos.CreateTodoView = SC.TextField.extend({
    insertNewline: function() {
      var value;
      value = this.get('value');
      if (value) {
        Todos.todoListController.createTodo(value);
        return this.set('value', '');
      }
    }
  });
  Todos.MarkDoneView = SC.Checkbox.extend({
    titleBinding: '.parentView.content.title',
    valueBinding: '.parentView.content.isDone'
  });
  Todos.StatsView = SC.TemplateView.extend({
    remainingBinding: 'Todos.todoListController.remaining',
    displayRemaining: (function() {
      var remaining, _ref;
      remaining = this.get('remaining');
      return "" + remaining + " " + ((_ref = remaining === 1) != null ? _ref : {
        " item": " items"
      });
    }).property('remaining')
  });
  SC.ready(function() {
    return Todos.mainPane = SC.TemplatePane.append({
      layerId: 'todos',
      templateName: 'todos'
    });
  });
  Todos.todoListController = SC.ArrayController.create({
    content: [],
    createTodo: function(title) {
      var todo;
      todo = Todos.Todo.create({
        title: title
      });
      return this.pushObject(todo);
    },
    remaining: (function() {
      return this.filterProperty('isDone', false).get('length');
    }).property('@each.isDone'),
    clearCompletedTodos: function() {
      return this.filterProperty('isDone', true).forEach(this.removeObject, this);
    },
    allAreDone: (function(key, value) {
      if (value !== void 0) {
        this.setEach('isDone', true);
        return value;
      } else {
        return this.get('length') && this.everyProperty('isDone', true);
      }
    }).property('@each.isDone')
  });
  window.Todos = Todos;
}).call(this);
