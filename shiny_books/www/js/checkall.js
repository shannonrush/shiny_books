$(document).on("click", "button.checkall", function(evt) {
    
    // evt.target is the button that was clicked
    var el = $('input[type="checkbox"][name="genres"]');
  
  // Check all genres checkboxes
  el.prop("checked" , true);

  // Raise an event to signal that the value changed
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