/**
 * Created by Tomek on 20.10.16.
 */
var Tweet = function (settings) {
    this.settings = $.extend({}, $.fn.init.defaults, settings);

    this.tbodyName = this.settings.tbodyName;
    this.tableName = this.settings.tableName;
    this.tableId = this.settings.tableId;
    this.paginContainer = this.settings.paginContainer;
    this.iconId = this.settings.iconId;
    this.url = this.settings.url;
    this.boxId = this.settings.boxId;
    this.buttonId = this.settings.buttonId;
    return this;
}

Tweet.prototype = {
    enterOnSearchBox: function () {
        var _self= this;
        var id = _self.boxId;


        $(id).keypress(function (event) {
            if (event.keyCode == 13) {
                $(_self.buttonId).click();
            }
        });
    },
    getTweets: function () {
        var _self = this;
        this.removeOldContent();
        this.ajaxPost($(_self.boxId).val());
    },
    listenForSearchByTagButtonClick: function () {
        var _self = this;

        $(_self.buttonId).on('click', function () {
            _self.getTweets();

        });
    },

    removeOldContent: function () {
        var _self = this;
        $(_self.tbodyName).empty();
        $("nav").remove("."+_self.paginContainer);
        $(_self.iconId).removeClass('glyphicon-search').addClass('glyphicon-repeat faa-spin animated');
    },
    addPagination: function () {
        var _self = this;
        $(_self.tbodyName).paginathing({
            perPage: 3,
            insertAfter: _self.tableId,
            containerClass: _self.paginContainer
        });
    },
    ajaxPost: function (dataValue) {
        var _self = this;
        $.ajax({
            type: "POST",
            data: {
                "tag": dataValue
            },
            dataType: "json",
            url: this.url,
            success: function (data) {
                $(_self.iconId).removeClass('glyphicon-repeat faa-spin animated').addClass('glyphicon glyphicon-search');
                appendToTable(data, _self.tableName);
                refreshFilters();
                _self.addPagination();

            },
            error: function (e) {
                console.log(e)
                $(_self.iconId).removeClass('glyphicon-repeat faa-spin animated').addClass('glyphicon glyphicon-search');
            }
        });
    }
};
$.fn.init.defaults = {
    tbodyName: "#tweets",
    tableName: "tweets",
    tableId: "#tweetsTable",
    paginContainer: "tweets-container",
    iconId: '#iconTag',
    url: "/twitter/tweets",
    boxId: "#search",
    buttonId: '#submitButton'
}


function appendToTable(data, tableId) {
    var id = $("#" + tableId);

    $.each(data, function (index, val) {
        $(id).append("<tr> <td class='col-md-2'> <img class='img-responsive' src=' " + val.profileImageUrl + " ' </img>  </td> " +
            " <td class='col-md-1'>" + val.fromUser + "  </td> " +
            " <td class='col-md-5'>" + val.text + "  </td> " +
            " <td class='col-md-1'>" + val.source + "  </td></tr> "
        );
    });
}

function refreshFilters() {
    $('#filters').empty();
    $.get("/twitter/filters", function (filters) {
        $.each(filters, function (index, val) {
            $('#filters').append("<a href=#! class=list-group-item> <i class='fa fa-chevron-right'></i> <span>" + val.value + "</span></a>")
        });
    });
}