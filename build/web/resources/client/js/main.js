(function ($) {
    "use strict";

    // Spinner
    var spinner = function () {
        setTimeout(function () {
            if ($("#spinner").length > 0) {
                $("#spinner").removeClass("show");
            }
        }, 1);
    };
    spinner(0);

    // Fixed Navbar
    $(window).scroll(function () {
        if ($(window).width() < 992) {
            if ($(this).scrollTop() > 55) {
                $(".fixed-top").addClass("shadow");
            } else {
                $(".fixed-top").removeClass("shadow");
            }
        } else {
            if ($(this).scrollTop() > 55) {
                $(".fixed-top").addClass("shadow").css("top", 0);
            } else {
                $(".fixed-top").removeClass("shadow").css("top", 0);
            }
        }
    });

    // Back to top button
    $(window).scroll(function () {
        if ($(this).scrollTop() > 300) {
            $(".back-to-top").fadeIn("slow");
        } else {
            $(".back-to-top").fadeOut("slow");
        }
    });
    $(".back-to-top").click(function () {
        $("html, body").animate({scrollTop: 0}, 1500, "easeInOutExpo");
        return false;
    });

    // Testimonial carousel
    $(".testimonial-carousel").owlCarousel({
        autoplay: true,
        smartSpeed: 2000,
        center: false,
        dots: true,
        loop: true,
        margin: 25,
        nav: true,
        navText: [
            '<i class="bi bi-arrow-left"></i>',
            '<i class="bi bi-arrow-right"></i>',
        ],
        responsiveClass: true,
        responsive: {
            0: {
                items: 1,
            },
            576: {
                items: 1,
            },
            768: {
                items: 1,
            },
            992: {
                items: 2,
            },
            1200: {
                items: 2,
            },
        },
    });

    // vegetable carousel
    $(".vegetable-carousel").owlCarousel({
        autoplay: true,
        smartSpeed: 1500,
        center: false,
        dots: true,
        loop: true,
        margin: 25,
        nav: true,
        navText: [
            '<i class="bi bi-arrow-left"></i>',
            '<i class="bi bi-arrow-right"></i>',
        ],
        responsiveClass: true,
        responsive: {
            0: {
                items: 1,
            },
            576: {
                items: 1,
            },
            768: {
                items: 2,
            },
            992: {
                items: 3,
            },
            1200: {
                items: 4,
            },
        },
    });

    // Modal Video
    $(document).ready(function () {
        var $videoSrc;
        $(".btn-play").click(function () {
            $videoSrc = $(this).data("src");
        });
        //        console.log($videoSrc);

        $("#videoModal").on("shown.bs.modal", function (e) {
            $("#video").attr(
                    "src",
                    $videoSrc + "?autoplay=1&amp;modestbranding=1&amp;showinfo=0"
                    );
        });

        $("#videoModal").on("hide.bs.modal", function (e) {
            $("#video").attr("src", $videoSrc);
        });
    });
})(jQuery);

const filterProduct = $(document).ready(function () {
    $("#btnFilter").click(function () {
        // Thu thập dữ liệu từ các bộ lọc
        let selectedBrands = [];
        document
                .querySelectorAll("#factoryFilter input[type=checkbox]:checked")
                .forEach((checkbox) => {
                    selectedBrands.push(checkbox.value);
                });
        let selectedPrices = [];
        document
                .querySelectorAll("#priceFilter input[type=checkbox]:checked")
                .forEach((checkbox) => {
                    selectedPrices.push(checkbox.value);
                });
        let selectedSort = document.querySelector(
                "input[name=radio-sort]:checked"
                ).value;
        // Tạo URL để gửi yêu cầu đến Servlet với các tham số lọc
        let url = `${
                window.location.pathname
                }?action=filter&brands=${selectedBrands.join(
                        ","
                        )}&prices=${selectedPrices.join(",")}&sort=${selectedSort}`;
        // Điều hướng tới URL đã tạo
        window.location.href = url;
    });
});

$(document).ready(function () {
    const addToCart = function () {
        $(".add-to-cart-btn")
                .off("click")
                .on("click", function (event) {
                    event.preventDefault();

                    let productId = $(this).data("id");
                    let contextPath = $(this).data("context");

                    $.ajax({
                        url: `${contextPath}/client?action=addToCart`,
                        type: "POST",
                        data: {id: productId},
                        success: function (response) {
                            if (response.success) {
                                $("#cart-count").text(response.cartItemCount);

                                $.toast({
                                    heading: "Giỏ hàng",
                                    text: response.message,
                                    showHideTransition: "slide",
                                    icon: "success",
                                    position: "top-right",
                                });
                                $("#cart-total").text(
                                        response.totalPrice.toLocaleString("vi-VN") + " đ"
                                        );
                            } else {
                                $.toast({
                                    heading: "Lỗi",
                                    text: response.message,
                                    showHideTransition: "slide",
                                    icon: "error",
                                    position: "top-right",
                                });
                            }
                        },
                        error: function (xhr, status, error) {
                            console.log("AJAX error:", error);
                            $.toast({
                                heading: "Lỗi",
                                text: "Có lỗi xảy ra. Vui lòng thử lại.",
                                showHideTransition: "slide",
                                icon: "error",
                                position: "top-right",
                            });
                        },
                    });
                });
    };

    const deleteOutOfCart = function () {
        $(".delete-out-of-cart-btn")
                .off("click")
                .on("click", function (event) {
                    event.preventDefault();

                    let productId = $(this).data("product-id");
                    let contextPath = $(this).data("context");

                    $.ajax({
                        url: `${contextPath}/client?action=removeFromCart`,
                        type: "POST",
                        data: {id: productId},
                        success: function (response) {
                            if (response.success) {

                                // Cập nhật lại số lượng sản phẩm trong giỏ hàng
                                console.log(response.cartItemCount);
                                $("#cart-count").text(response.cartItemCount);
                                $.toast({
                                    heading: "Giỏ hàng",
                                    text: response.message,
                                    showHideTransition: "slide",
                                    icon: "success",
                                    position: "top-right"
                                });
                                $("#cart-total").text(
                                        response.totalPrice.toLocaleString("vi-VN") + " đ"
                                        );
                                $("#cart-count").text(response.cartItemCount);

                                $(
                                        ".bg-light .d-flex.justify-content-between .mb-0[data-cart-total-price]"
                                        ).text(response.totalPrice.toLocaleString("vi-VN") + " đ");
                                // Xóa hàng tương ứng khỏi bảng
                                $(`#cart-item-${productId}`).closest("tr").remove();

                                // Kiểm tra nếu giỏ hàng trống
                                if ($("tbody tr").length === 0) {
                                    $("tbody").html(
                                            '<tr><td colspan="6">Không có sản phẩm trong giỏ hàng</td></tr>'
                                            );
                                }
                            } else {
                                $.toast({
                                    heading: "Lỗi",
                                    text: response.message,
                                    showHideTransition: "slide",
                                    icon: "error",
                                    position: "top-right",
                                });
                            }
                        },
                        error: function (xhr, status, error) {
                            console.log("AJAX error:", error);
                            $.toast({
                                heading: "Lỗi",
                                text: "Có lỗi xảy ra. Vui lòng thử lại.",
                                showHideTransition: "slide",
                                icon: "error",
                                position: "top-right",
                            });
                        },
                    });
                });
    };

    const increaseQuantity = function () {
        $(".btn-plus")
                .off("click")
                .on("click", function (event) {
                    event.preventDefault();

                    let productId = $(this).data("product-id");
                    let contextPath = $(this).data("context");

                    $.ajax({
                        url: `${contextPath}/client?action=updateCart`, // Đường dẫn tới servlet
                        type: "POST",
                        data: {
                            id: productId,
                            actionUpdate: "increase", // Gửi action "increase"
                        },
                        success: function (response) {
                            if (response.success) {
                                // Cập nhật số lượng trong ô input
                                let inputField = $('input[data-product-id="' + productId + '"]'); // Lấy input theo data-product-id
                                inputField.val(response.newQuantity);
                                // Cập nhật thành tiền cho sản phẩm
                                $('p[data-cart-detail-id="' + productId + '"]').text(
                                        response.newTotalPrice.toLocaleString("vi-VN") + " đ"
                                        );

                                // Cập nhật tổng giá cho toàn bộ giỏ hàng
                                $("p[data-cart-total-price]").text(
                                        response.totalPrice.toLocaleString("vi-VN") + " đ"
                                        );
                            } else {
                                // Xử lý nếu không thành công
                                alert(response.message);
                            }
                        },
                        error: function (xhr, status, error) {
                            console.error("Lỗi khi thực hiện yêu cầu:", status, error);
                        },
                    });
                });
    };

    const decreaseQuantity = function () {
        $(".btn-minus")
                .off("click")
                .on("click", function (event) {
                    event.preventDefault();

                    let productId = $(this).data("product-id");
                    let contextPath = $(this).data("context");

                    let quantity = $('input[data-product-id="' + productId + '"]'); // Lấy input theo data-product-id
                    if (quantity.valueOf() === 1) {

                    }

                    $.ajax({
                        url: `${contextPath}/client?action=updateCart`, // Đường dẫn tới servlet
                        type: "POST",
                        data: {
                            id: productId,
                            actionUpdate: "decrease", // Gửi action "decrease"
                        },
                        success: function (response) {
                            if (response.success) {
                                // Cập nhật số lượng trong ô input
                                let inputField = $('input[data-product-id="' + productId + '"]'); // Lấy input theo data-product-id
                                inputField.val(response.newQuantity);

                                // Nếu số lượng = 1, disable ô input
                                if (response.newQuantity <= 1) {
                                    inputField.prop("disabled", true);
                                } else {
                                    inputField.prop("disabled", false);
                                }

                                // Cập nhật thành tiền cho sản phẩm
                                $('p[data-cart-detail-id="' + productId + '"]').text(
                                        response.newTotalPrice.toLocaleString("vi-VN") + " đ"
                                        );

                                // Cập nhật tổng giá cho toàn bộ giỏ hàng
                                $("p[data-cart-total-price]").text(
                                        response.totalPrice.toLocaleString("vi-VN") + " đ"
                                        );
                            } else {
                                $.toast({
                                    heading: "Warning",
                                    text: response.message,
                                    showHideTransition: "slide",
                                    icon: "error",
                                    position: "top-right",
                                });
                            }
                        },
                        error: function (xhr, status, error) {
                            console.error("Lỗi khi thực hiện yêu cầu:", status, error);
                        },
                    });
                });
    };

    addToCart(); // Gọi hàm để gán sự kiện ngay khi tài liệu đã sẵn sàng
    deleteOutOfCart();
    increaseQuantity();
    decreaseQuantity();
});
