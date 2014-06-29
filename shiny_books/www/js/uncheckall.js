$(document).on("click", "button.uncheckall", function(evt) {
    var el = $('input[type="checkbox"][name='+evt.target.name+']');
    el.prop("checked" , false);
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