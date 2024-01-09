import 'dart:io';

import 'package:cinemax/application/enums/group_type.dart';
import 'package:cinemax/data/data_sources/api/api_response.dart';
import 'package:cinemax/domain/models/request/auth/login_request.dart';
import 'package:cinemax/domain/models/request/auth/register_request.dart';
import 'package:cinemax/domain/models/request/auth/reset_password_request.dart';
import 'package:cinemax/domain/models/request/booking/create_booking_request.dart';
import 'package:cinemax/domain/models/request/booking/create_vnpay_payment_request.dart';
import 'package:cinemax/domain/models/request/booking/get_list_bookings_request.dart';
import 'package:cinemax/domain/models/request/cinemas/favorite_cinema_request.dart';
import 'package:cinemax/domain/models/request/cinemas/get_list_cinemas_request.dart';
import 'package:cinemax/domain/models/request/home/get_carousel_slider_request.dart';
import 'package:cinemax/domain/models/request/home/get_list_categories_request.dart';
import 'package:cinemax/domain/models/request/home/get_list_groups_request.dart';
import 'package:cinemax/domain/models/request/movies/favorite_movie_request.dart';
import 'package:cinemax/domain/models/request/movies/get_list_movies_by_group_request.dart';
import 'package:cinemax/domain/models/request/movies/get_list_movies_request.dart';
import 'package:cinemax/domain/models/request/movies/rating_movie_request.dart';
import 'package:cinemax/domain/models/request/news/get_list_news_request.dart';
import 'package:cinemax/domain/models/response/auth/login_response.dart';
import 'package:cinemax/domain/models/response/booking/booking_detail_response.dart';
import 'package:cinemax/domain/models/response/booking/booking_response.dart';
import 'package:cinemax/domain/models/response/booking/seat_response.dart';
import 'package:cinemax/domain/models/response/cinemas/cinema_detail_response.dart';
import 'package:cinemax/domain/models/response/cinemas/cinema_response.dart';
import 'package:cinemax/domain/models/response/home/carousel_slider_response.dart';
import 'package:cinemax/domain/models/response/home/category_response.dart';
import 'package:cinemax/domain/models/response/home/group_response.dart';
import 'package:cinemax/domain/models/response/movies/movie_detail_response.dart';
import 'package:cinemax/domain/models/response/movies/movie_response.dart';
import 'package:cinemax/domain/models/response/news/news_detail_response.dart';
import 'package:cinemax/domain/models/response/news/news_response.dart';
import 'package:cinemax/domain/models/response/schedulers/scheduler_cinema_response.dart';
import 'package:cinemax/domain/models/response/schedulers/scheduler_detail_response.dart';
import 'package:cinemax/domain/models/response/user/user_response.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'api_client.g.dart';

@RestApi(baseUrl: '')
abstract class ApiClient {
  factory ApiClient(Dio dio, {String? baseUrl}) = _ApiClient;

  ///-------------------AUTH------------------///
  @POST("/Account/Sign-In")
  Future<ApiResponse<LoginResponse>> login(@Body() LoginRequest body);

  @POST("/Account/Create-Account")
  Future<ApiResponse> register(@Body() RegisterRequest body);

  @PUT("/Account/Change-Password")
  Future<ApiResponse> resetPassword(@Body() ResetPasswordRequest body);

  @DELETE("/Account/Logout")
  Future<ApiResponse> logout();

  @POST("/Account/Create-Or-Update-Account-Favorite")
  Future<ApiResponse> favoriteMovie(@Body() FavoriteMovieRequest body);

  @POST("/Account/Create-Or-Update-Account-Favorite")
  Future<ApiResponse> favoriteCinema(@Body() FavoriteCinemaRequest body);

  ///-------------------HOME------------------///
  @POST("/Category/View-List-Categories")
  Future<ApiResponse<ListDataResponse<CategoryResponse>>> getListCategories(@Body() GetListCategoriesRequest body);

  @POST("/Slide/View-List-Slides")
  Future<ApiResponse<ListDataResponse<CarouselSliderResponse>>> getCarouselSlider(@Body() GetCarouselSliderRequest body);

  @POST("/Group/View-List-Groups")
  Future<ApiResponse<ListDataResponse<GroupResponse>>> getListGroups(
    @Body() GetListGroupsRequest body, {
    @Query("type") GroupType? type,
  });

  ///-------------------CINEMA------------------///
  @GET("/Theater/View-Theater/{cinemaId}")
  Future<ApiResponse<CinemaDetailResponse>> getCinemaDetail(@Path("cinemaId") int cinemaId);

  @POST("/Theater/View-List-Theaters")
  Future<ApiResponse<ListDataResponse<CinemaResponse>>> getListCinemas(@Body() GetListCinemasRequest body);

  @POST("/Scheduler/View-List-Theater-By-Film/{movieId}")
  Future<ApiResponse<ListDataResponse<CinemaResponse>>> getListCinemasByMovie({
    @Body() GetListCinemasRequest? body,
    @Path("movieId") int? movieId,
  });

  @POST("/Theater/View-List-Theaters-Favorites")
  Future<ApiResponse<ListDataResponse<CinemaResponse>>> getListFavoriteCinemas(@Body() GetListCinemasRequest body);

  @POST("/Scheduler/View-List-Theater-By-Film/{movieId}")
  Future<ApiResponse<ListDataResponse<CinemaResponse>>> getFavoriteCinemasByMovie({
    @Body() GetListCinemasRequest? body,
    @Path("movieId") int? movieId,
    @Query("tab") String tab = 'Favorites',
  });

  ///-------------------MOVIE------------------///
  @POST("/Film/View-List-Films-By-Group")
  Future<ApiResponse<ListDataResponse<MovieResponse>>> getListMoviesByGroup(@Body() GetListMoviesByGroupRequest body);

  @POST("/Film/View-List-Films-Favorites")
  Future<ApiResponse<ListDataResponse<MovieResponse>>> getListFavoriteMovies(@Body() GetListMoviesRequest body);

  @GET("/Film/View-Film/{movieId}")
  Future<ApiResponse<MovieDetailResponse>> getMovieDetail(@Path("movieId") int movieId);

  @POST("/Film/Create-Film-Feedback")
  Future<ApiResponse> ratingMovie(@Body() RatingMovieRequest body);

  ///-------------------SCHEDULER------------------///
  @GET("/Scheduler/View-List-Schedulers/{cinemaId}")
  Future<ApiResponse<List<SchedulerCinemaResponse>>> getListSchedulers({
    @Path("cinemaId") int? cinemaId,
    @Query("date") String? date,
  });

  @GET("/Scheduler/View-List-Schedulers/{cinemaId}/{movieId}")
  Future<ApiResponse<List<SchedulerCinemaResponse>>> getSchedulerByMovie({
    @Path("cinemaId") int? cinemaId,
    @Path("movieId") int? movieId,
    @Query("date") String? date,
  });

  @GET("/Scheduler/View-Scheduler/{schedulerId}")
  Future<ApiResponse<SchedulerDetailResponse>> getSchedulerDetail(@Path("schedulerId") int schedulerId);

  ///-------------------BOOKING------------------///
  @GET("/Seat/View-List-Seats-By-Scheduler/{schedulerId}")
  Future<ApiResponse<List<SeatResponse>>> getListBookingSeats(@Path("schedulerId") int schedulerId);

  @POST("/Booking/View-List-Bookings")
  Future<ApiResponse<ListDataResponse<BookingResponse>>> getListBookings(@Body() GetListBookingsRequest body);

  @POST("/Booking/Create-Booking")
  Future<ApiResponse> createBooking(@Body() CreateBookingRequest body);

  @GET("/Booking/View-Booking/{bookingId}")
  Future<ApiResponse<BookingDetailResponse>> getBookingDetail(@Path("bookingId") int bookingId);

  @POST("/Booking/payment-vnpay")
  Future<String> createVnPayPayment(@Body() CreateVnPayPaymentRequest body);

  @DELETE("/Booking/Cancel-Booking/{id}")
  Future<ApiResponse> cancelBooking(@Path("id") int id);

  ///-------------------USER------------------///
  @GET("/Account/View-My-Account")
  Future<ApiResponse<UserResponse>> getUserProfile();

  @PUT("/Account/Update-Account")
  Future<ApiResponse> updateUserProfile({
    @Part(name: "Email") String? email,
    @Part(name: "FullName") String? fullName,
    @Part(name: "PhoneNumber") String? phoneNumber,
    @Part(name: "Gender") bool? gender,
    @Part(name: "AvatarPhoto") File? avatarPhoto,
  });

  ///-------------------NEWS------------------///
  @POST("/News/View-List-News")
  Future<ApiResponse<ListDataResponse<NewsResponse>>> getListNews(@Body() GetListNewsRequest body);

  @GET("/News/View-News/{newsId}")
  Future<ApiResponse<NewsDetailResponse>> getNewsDetail(@Path("newsId") int newsId);
}
