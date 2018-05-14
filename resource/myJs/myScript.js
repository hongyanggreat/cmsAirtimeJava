$(document).ready(function () {
    $("body").on('click', '#user', function (event) {
        event.preventDefault();
        var cpCode = $('option:selected', this).attr("cpCode");
        $("#cpCode").val(cpCode).trigger('change');
        getCpGame(cpCode);
    });
    $("body").on('click', '#cpCode', function (event) {
        event.preventDefault();
        var cpCode = $(this).val();
        var user = $('option:selected', this).attr("user");
        $("#user").val(user).trigger('change');
        getCpGame(cpCode);
    });
   
    $("body").on('click', '#cpGame', function (event) {
        event.preventDefault();
        var cpGame = $(this).val();
        var accessKey = $('option:selected', this).attr('ak');
        console.log("accessKey la :" + accessKey);
        if (cpGame != "all") {
            var user = $('option:selected', this).attr("user");
            var cpCode = $('option:selected', this).attr("cpCode");
            $("#user").val(user).trigger('change');
            $("#cpCode").val(cpCode).trigger('change');
            $('#accesskey').val(accessKey);
        } else {
            $('#accesskey').val("");
        }
    });

    function getCpGame(cpCode) {

        var l = window.location;
//            var base_url = l.protocol + "//" + l.host + "/" + l.pathname.split('/')[1];
        var base_url = l.protocol + "//" + l.host;
        var url = base_url + "/ajaxFile/cpGame.jsp";
        console.log(url);
        $.ajax({
            url: url,
            type: "post",
            dataType: "html",
            data: {cpCode: cpCode},
            beforeSend: function () {
//                    //lAM GI DE KHONG CHO DUPLEX
            },
            success: function (response) {
//                    console.log(response);
                $("#cpGame").html(response).trigger("change");
                $('#accesskey').val("");
            },
            error: function (jqXHR, textStatus, errorThrown) {
                console.log(textStatus, errorThrown);
            }
        });
    }


});