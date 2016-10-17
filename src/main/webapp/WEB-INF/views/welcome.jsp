<%--
  Created by IntelliJ IDEA.
  User: neptis
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

    <link rel='stylesheet' href='<c:url value="/resources/css/style.css" />' type='text/css' media='all'/>
    <link href='<c:url value="/resources/css/bootstrap.min.css" />' rel="stylesheet">
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
                <div class="col-md-6 col-lg-6">
                    <div>
                        <div class="input-group">
                            <input id="search" type="text" class="form-control" placeholder="Search for...">
                            <span class="input-group-btn">
                            <button id="submitButton" class="btn btn-default" type="submit">Search <span
                                    class="glyphicon glyphicon-search" aria-hidden="true"></span>
                            </button>
                        </span>
                        </div><!-- /input-group -->
                    </div><!-- /.col-lg-6 -->

                    <div id="tweetsTableDiv">
                        <table id="tweetsTable" class="table table-hover ">
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
                <div class="col-md-6 col-lg-6">
                    <div>
                        <div class="input-group">
                            <input id="searchPeople" type="text" class="form-control" placeholder="Search for...">
                            <span class="input-group-btn">
                            <button id="submitPeople" class="btn btn-default" type="submit">Search <span
                                    class="glyphicon glyphicon-search" aria-hidden="true"></span>
                            </button>
                        </span>
                        </div><!-- /input-group -->
                    </div><!-- /.col-lg-6 -->

                    <div id="tweetsPeopleDiv">
                        <table id="tweetsTablePeople" class="table table-hover ">
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
            </div>
        </div>
    </div>
</section>
<script src='<c:url value="/resources/js/jquery-3.1.1.js"/>'></script>
<script src='<c:url value="/resources/js/bootstrap.min.js"/>'></script>
<script src='<c:url value="/resources/js/paginathing.js"/>'></script>

<script type="text/javascript">
    function appendToTable(data, tableId) {
        var id = $("#"+tableId);
        console.log(id);
        $.each(data, function (index, val) {
            $(id).append("<tr> <td class='col-md-2'> <img class='img-responsive' src=' " + val.profileImageUrl + " ' </img>  </td> " +
                    " <td class='col-md-1'>" + val.fromUser + "  </td> " +
                    " <td class='col-md-5'>" + val.text + "  </td> " +
                    " <td class='col-md-1'>" + val.source + "  </td></tr> "
            );
        });
    }
    function getTweetsByTag() {
        $('#submitButton').on('click', function () {
            $('#tweets').empty();
            $('.tweets-container').remove();

            var tag = $('#search').val();

            $.ajax({
                type: "POST",
                data: {"tag": tag},
                dataType: "json",
                url: "/twitter/tweets",
                success: function (data) {
                    appendToTable(data, 'tweets');

                    $('#tweets').paginathing({
                        perPage: 3,
                        limitPagination: 4,
                        insertAfter: '#tweetsTable',
                        containerClass: 'tweets-container'
                    });
                }
            });

        });
    }
    function getTweetsByPerson() {
        $('#submitPeople').on('click', function () {
            $('#tweetsPeople').empty();
            $('.tweets-container-people').remove();

            var person = $('#searchPeople').val();

            $.ajax({
                type: "POST",
                data: {"name": person},
                dataType: "json",
                url: "/twitter/person",
                success: function (data) {
                    appendToTable(data, 'tweetsPeople');

                    $('#tweetsPeople').paginathing({
                        perPage: 3,
                        limitPagination: 4,
                        insertAfter: '#tweetsTablePeople',
                        containerClass: 'tweets-container-people'
                    });
                }
            });

        });
    }
</script>


<script type="text/javascript">
    $(document).ready(function () {
        getTweetsByTag();
        getTweetsByPerson();
    });

</script>

</body>
</html>
