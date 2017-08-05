HTMLWidgets.widget({
  name: 'Rearth',
  type: 'output',
  factory: function(el, width, height) {
    return {
      renderValue: function(x) {
        el.innerText = x.viewpoint;
		location.replace(el.innerText);
      },
      resize: function(el, width, height) {
        // re-render the widget with a new size
		location.reload();
      }
    };
  }
});