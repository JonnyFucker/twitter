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
    <meta name="description" content="">
    <meta name="author" content="">

    <link href='<c:url value="/resources/css/bootstrap.min.css" />' rel="stylesheet">
    <link href='<c:url value="/resources/css/style.css" />' rel="stylesheet">
    <link href='<c:url value="/resources/css/font-awesome-animation.min.css" />' rel="stylesheet">


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
                        <div class="input-group">
                            <input id="search" type="text" class="form-control"
                                   placeholder="Search for tweets using key words">
                            <span class="input-group-btn">
                            <button id="submitButton" class="btn btn-default faa-parent animated-hover" type="submit">Search <span
                                    id="iconTag"
                                    class="glyphicon glyphicon-search" aria-hidden="true"></span>
                            </button>
                        </span>
                        </div><!-- /input-group -->
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
                    <div>
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
        enterOnSearchBox('search');
        enterOnSearchBox('searchPeople');
        refreshFilters();
        getTweetsByTag();
        getTweetsByPerson();

        $('a').click(function () {
            var text = $(this).text();
            console.log(text);
        });
    });

</script>

<script type="text/javascript">

    function refreshFilters() {
        $('#filters').empty();
        $.get("/twitter/filters",function (filters) {
            $.each(filters,function (index, val) {
                console.log(val);
                $('#filters').append("<a class='list-group-item list-group-item-info'>"+val.value+"</a>")
            });
        });
    }

    function enterOnSearchBox(boxId) {
        var id = $("#" + boxId);
        $(id).keypress(function (event) {
            if (event.keyCode == 13) {
                if (boxId == 'search') {
                    $('#submitButton').click();
                    refreshFilters();
                }
                if (boxId == 'searchPeople') {
                    $('#submitPeople').click();
                    refreshFilters();
                }
            }
        });
    }

    function getTweetsByTag() {
         $('#submitButton').on('click', function () {
            $('#tweets').empty();
            $('.tweets-container').remove();
            $('#iconTag').removeClass('glyphicon-search').addClass('glyphicon-repeat faa-spin animated');
            var tag = $('#search').val();
            getTweetsByKeyWord(tag);

        });
    }
    function getTweetsByPerson() {

        $('#submitPeople').on('click', function () {
            $('#tweetsPeople').empty();
            $('.tweets-container-people').remove();
            $('#iconPeople').removeClass('glyphicon-search').addClass('glyphicon-repeat faa-spin animated');

            var person = $('#searchPeople').val();
            getTweetsByChannelName(person);

        });
    }

    function getTweetsByChannelName(person) {
        $.ajax({
            type: "POST",
            data: {"name": person},
            dataType: "json",
            url: "/twitter/person",
            success: function (data) {
                $('#iconPeople').removeClass('glyphicon-repeat faa-spin animated').addClass('glyphicon glyphicon-search');
                appendToTable(data, 'tweetsPeople');

                $('#tweetsPeople').paginathing({
                    perPage: 3,
                    limitPagination: 4,
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
        $.ajax({
            type: "POST",
            data: {"tag": tag},
            dataType: "json",
            url: "/twitter/tweets",
            success: function (data) {
                $('#iconTag').removeClass('glyphicon-repeat faa-spin animated').addClass('glyphicon glyphicon-search');
                appendToTable(data, 'tweets');

                $('#tweets').paginathing({
                    perPage: 3,
                    limitPagination: 4,
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
        console.log(id);
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