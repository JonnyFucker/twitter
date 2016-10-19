<%--
  Created by IntelliJ IDEA.
  User: Tomek
  Date: 17.10.16
  Time: 09:13
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c"
           uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <%@ page isELIgnored="false" %>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="twitterApp">
    <meta name="author" content="Tomasz Zielichowski">

    <link href='<c:url value="/resources/css/bootstrap.min.css" />' rel="stylesheet">
    <link href='<c:url value="/resources/css/style.css" />' rel="stylesheet">
    <link href='<c:url value="/resources/css/font-awesome-animation.min.css" />' rel="stylesheet">
    <link href='<c:url value="/resources/css/font-awesome.min.css" />' rel="stylesheet">


    <%--
                <link href="/resources/css/bootstrap.min.css" rel="stylesheet">
            --%>
    <title>Twitter
        by Tomasz Zielichowski
    </title>

</head>
<body>

<section>
    <div class="container">
        <div class="row">
            <div class="col-lg-12 margin">
                <div class="col-md-5 col-lg-5">
                    <div>
                        <div class="well">
                            <h4>Use key words to search</h4>
                            <div class="input-group">
                                <input id="search" type="text" class="form-control"
                                       placeholder="Search for tweets using key words">
                                <span class="input-group-btn">
                            <button id="submitButton" class="btn btn-default faa-parent animated-hover" type="submit">Search
                                <span id="iconTag" class="glyphicon glyphicon-search" aria-hidden="true"> </span>
                            </button>
                            </span>
                            </div><!-- /input-group -->
                        </div>
                    </div>
                    <!-- /.col-lg-6 -->
                    <div id="tweetsTableDiv">
                        <table id="tweetsTable" class="table table-hover table-condensed">
                            <thead>
                            <tr class="text-info">
                                <th>Image</th>
                                <th>User</th>
                                <th>Text</th>
                                <th>Source</th>
                            </tr>
                            </thead>
                            <tbody id="tweets">
                            </tbody>
                        </table>
                    </div>
                </div>
                <div class="col-md-5 col-lg-5">
                    <div class="well">
                        <h4>Use channels to search</h4>
                        <div class="input-group">
                            <input id="searchPeople" type="text" class="form-control"
                                   placeholder="Search for tweets using channel name">
                            <span class="input-group-btn">
                            <button id="submitPeople" class="btn btn-default faa-parent animated-hover" type="submit">Search <span
                                    id="iconPeople"
                                    class="glyphicon glyphicon-search" aria-hidden="true"></span>
                            </button>
                        </span>
                        </div><!-- /input-group -->
                    </div>
                    <!-- /.col-lg-6 -->
                    <div id="tweetsPeopleDiv">
                        <table id="tweetsTablePeople" class="table table-hover table-condensed">
                            <thead>
                            <tr class="text-info">
                                <th>Image</th>
                                <th>User</th>
                                <th>Text</th>
                                <th>Source</th>
                            </tr>
                            </thead>
                            <tbody id="tweetsPeople">
                            </tbody>
                        </table>
                    </div>
                </div>
                <div class="col-lg-2 col-md-2">
                    <h4 class="list-group-item active"><i class="fa fa-align-justify"></i> Filters</h4>
                    <div class="list-group" id="filters">

                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
<script src='<c:url value="/resources/js/jquery-3.1.1.js"/>'></script>
<script src='<c:url value="/resources/js/bootstrap.min.js"/>'></script>
<script src='<c:url value="/resources/js/paginathing.js"/>'></script>

<script type="text/javascript">
    $(document).ready(function () {
/*        enterOnSearchBox('search');
        enterOnSearchBox('searchPeople');
        refreshFilters();
        getTweetsByTag();
        getTweetsByPerson();*/

        $('#filters').on('click', 'a', function () {
            var filterValue = $(this).children().text();
            console.log(filterValue);

            $.get("/twitter/filters/" + filterValue, function (filterSource) {
                //console.log(filterSource);
                getTweets(filterSource, filterValue);
            });

        });

    });


    var twitterAction = {

        init: function (settings) {
            twitterAction.config = {
                tbodyName: "#tweets",
                paginContainer: ".tweets-container",
                iconId: '#iconTag',
                dataKey: 'name',
                //dataValue: "brown",
                url: "/twitter/tweets",
                boxId: "#search",
                buttonId: '#submitButton'
            },
                    o = $.extend(twitterAction.config, settings)
        },

        enterOnSearchBox: function () {
            var id = twitterAction.config.boxId;
            console.log(id);
            $(id).keypress(function (event) {
                if (event.keyCode == 13) {
                    $(twitterAction.config.buttonId).click();
                }
            });
        },
        listenForSearchByTagButtonClick: function () {
            $(twitterAction.config.buttonId).on('click', function () {
                this.cos;

            });
        },
        cos: function () {
            var tag = $(twitterAction.config.boxId).val();
            console.log(tag)
            this.removeOldContent();
            this.ajaxPost(tag);
        },
        removeOldContent: function () {
            $(twitterAction.config.tbodyName).empty();
            $(twitterAction.config.paginContainer).remove();
            $(twitterAction.config.iconId).removeClass('glyphicon-search').addClass('glyphicon-repeat faa-spin animated');
        },
        ajaxPost: function (dataValue) {
            $.ajax({
                type: "POST",
                data: JSON.stringify({
                    tag: dataValue
                }),
                dataType: "json",
                url: twitterAction.config.url,
                success: function (data) {
                    $(twitterAction.config.iconId).removeClass('glyphicon-repeat faa-spin animated').addClass('glyphicon glyphicon-search');
                    appendToTable(data, 'tweets');
                    refreshFilters();

                    $(twitterAction.config.tbodyName).paginathing({
                        perPage: 3,
                        insertAfter: '#tweetsTable',
                        containerClass: 'tweets-container'
                    });
                },
                error: function () {
                    $(twitterAction.config.iconId).removeClass('glyphicon-repeat faa-spin animated').addClass('glyphicon glyphicon-search');
                }
            });
        }
    };
    twitterAction.init();
    twitterAction.enterOnSearchBox();
    twitterAction.listenForSearchByTagButtonClick();


</script>

<script type="text/javascript">

    function refreshFilters() {
        $('#filters').empty();
        $.get("/twitter/filters", function (filters) {
            $.each(filters, function (index, val) {
                $('#filters').append("<a href=#! class=list-group-item> <i class='fa fa-chevron-right'></i> <span>" + val.value + "</span></a>")
            });
        });
    }

    function enterOnSearchBox(boxId) {
        var id = $("#" + boxId);
        $(id).keypress(function (event) {
            if (event.keyCode == 13) {
                if (boxId == 'search') {
                    $('#submitButton').click();
                }
                if (boxId == 'searchPeople') {
                    $('#submitPeople').click();
                }
            }
        });
    }

    function getTweetsByTag() {
        $('#submitButton').on('click', function () {
            var tag = $('#search').val();
            getTweetsByKeyWord(tag);

        });
    }
    function getTweetsByPerson() {

        $('#submitPeople').on('click', function () {
            var person = $('#searchPeople').val();
            getTweetsByChannelName(person);

        });
    }

    function getTweets(filterSource, filterValue) {
        if (filterSource == 'tweets') {
            getTweetsByKeyWord(filterValue);
        }
        else if (filterSource == 'person') {
            getTweetsByChannelName(filterValue);
        }
    }

    function getTweetsByChannelName(person) {
        $('#tweetsPeople').empty();
        $('.tweets-container-people').remove();
        $('#iconPeople').removeClass('glyphicon-search').addClass('glyphicon-repeat faa-spin animated');
        $.ajax({
            type: "POST",
            data: {"name": person},
            dataType: "json",
            url: "/twitter/person",
            success: function (data) {
                $('#iconPeople').removeClass('glyphicon-repeat faa-spin animated').addClass('glyphicon glyphicon-search');
                appendToTable(data, 'tweetsPeople');
                refreshFilters();

                $('#tweetsPeople').paginathing({
                    perPage: 3,
                    insertAfter: '#tweetsTablePeople',
                    containerClass: 'tweets-container-people'
                });
            },
            error: function () {
                $('#iconPeople').removeClass('glyphicon-repeat faa-spin animated').addClass('glyphicon glyphicon-search');
            }
        });
    }

    function getTweetsByKeyWord(tag) {
        $('#tweets').empty();
        $('.tweets-container').remove();
        $('#iconTag').removeClass('glyphicon-search').addClass('glyphicon-repeat faa-spin animated');
        $.ajax({
            type: "POST",
            data: {"tag": tag},
            dataType: "json",
            url: "/twitter/tweets",
            success: function (data) {
                $('#iconTag').removeClass('glyphicon-repeat faa-spin animated').addClass('glyphicon glyphicon-search');
                appendToTable(data, 'tweets');
                refreshFilters();

                $('#tweets').paginathing({
                    perPage: 3,
                    insertAfter: '#tweetsTable',
                    containerClass: 'tweets-container'
                });
            },
            error: function () {
                $('#iconTag').removeClass('glyphicon-repeat faa-spin animated').addClass('glyphicon glyphicon-search');
            }
        });
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
</script>
</body>
</html>
