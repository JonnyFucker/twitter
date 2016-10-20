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
<script src='<c:url value="/resources/js/twitterScript.js"/>'></script>

<script type="text/javascript">
    $(document).ready(function () {
        refreshFilters();

        var getTweetsByTag = new Tweet();
        getTweetsByTag.enterOnSearchBox();
        getTweetsByTag.listenForSearchByTagButtonClick();

        var getTweetsByChannel = new Tweet({
            tbodyName: "#tweetsPeople",
            tableName: "tweetsPeople",
            tableId: "#tweetsTablePeople",
            paginContainer: "tweets-container-people",
            iconId: '#iconPeople',
            url: "/twitter/person",
            boxId: "#searchPeople",
            buttonId: '#submitPeople'
        });

        getTweetsByChannel.enterOnSearchBox();
        getTweetsByChannel.listenForSearchByTagButtonClick();


        $('#filters').on('click', 'a', function () {
            var filterValue = $(this).children().text();
            console.log(filterValue);

            $.get("/twitter/filters/" + filterValue, function (filterSource) {
                getTweets(filterSource, filterValue);
            });

        });

        function getTweets(filterSource, filterValue) {
            if (filterSource == 'tweets') {
                getTweetsByTag.removeOldContent();
                getTweetsByTag.ajaxPost(filterValue);
            }
            else if (filterSource == 'person') {
                getTweetsByChannel.removeOldContent();
                getTweetsByChannel.ajaxPost(filterValue);
            }
        }




    });


</script>
</body>
</html>
