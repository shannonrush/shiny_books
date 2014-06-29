$(document).on("click", "button.checkall", function(evt) {
    var el = $('input[type="checkbox"][name='+evt.target.name+']');
    el.prop("checked" , true);
    el.trigger("change");
});

var checkallBinding = new Shiny.InputBinding();
$.extend(checkallBinding, {
  find: function(scope) {
    return $(scope).find(".checkall");
  },
    getValue: function(el) {
    return parseInt($(el).text());
  },
  setValue: function(el, value) {
    $(el).text(value);
  },
  subscribe: function(el, callback) {
    $(el).on("change.checkallBinding", function(e) {
      callback();
    });
  },
  unsubscribe: function(el) {
    $(el).off(".checkallBinding");
  }
});

Shiny.inputBindings.register(checkallBinding);