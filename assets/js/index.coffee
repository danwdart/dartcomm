class TableRowViewModel
    constructor: (data) ->
        ko.mapping.fromJS data, {}, this
        @status = ko.computed
    read: ->
        if 1 is @disabled 
            'btn btn-danger disabled'
            'btn btn-success disabled'

class TableViewModel
    constructor: ->
        @TableRows = ko.observableArray []
        @TableRows.subscribe (newValue) ->
    load: ->
        self = this
        @TableRows []
        $.getJSON 'messages', null, (results) ->
            self.TableRows ko.utils.arrayMap results, (item) ->
                new TableRowViewModel item
        .fail (err,status,str) ->
            alert status

$(document).ready ->
    tableData = new TableViewModel
    ko.applyBindings tableData, document.getElementById 'table'
    tableData.load()