class AccountRowViewModel
    constructor: (data) ->
        ko.mapping.fromJS data, {}, this
        @status = ko.computed

class AccountTableViewModel
    constructor: ->
        @TableRows = ko.observableArray []
        @TableRows.subscribe (newValue) ->
    load: ->
        self = this
        @TableRows []
        $.getJSON 'settings/accounts', null, (results) ->
            self.TableRows ko.utils.arrayMap results, (item) ->
                new AccountRowViewModel item
        .fail (err,status,str) ->
            alert status

$(document).ready ->
    tableData = new AccountTableViewModel
    ko.applyBindings tableData, document.getElementById 'accounts'
    tableData.load()