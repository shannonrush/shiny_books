$(document).on("click", "button.uncheckall", function(evt) {
    
    // evt.target is the button that was clicked
    var el = $('input[type="checkbox"][name="genres"]');
  
  // Check all genres checkboxes
  el.prop("checked" , false);

  // Raise an event to signal that the value changed
  el.trigger("change");
});

var uncheckallBinding = new Shiny.InputBinding();
$.extend(uncheckallBinding, {
  find: function(scope) {
    return $(scope).find(".uncheckall");
  },
    getValue: function(el) {
    return parseInt($(el).text());
  },
  setValue: function(el, value) {
    $(el).text(value);
  },
  subscribe: function(el, callback) {
    $(el).on("change.uncheckallBinding", function(e) {
      callback();
    });
  },
  unsubscribe: function(el) {
    $(el).off(".uncheckallBinding");
  }
});

Shiny.inputBindings.register(uncheckallBinding);