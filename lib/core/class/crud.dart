import 'dart:convert';
import 'dart:io';

import 'package:admin_app/core/class/statusrequest.dart';
import 'package:admin_app/core/errors/failures.dart';
import 'package:admin_app/core/functions/checkinternet.dart';
import 'package:dartz/dartz.dart';
import 'package:path/path.dart';
import 'package:http/http.dart' as http;

import 'package:dio/dio.dart';



class Crud {
  // Future<Either<StatusRequest, Map<String, dynamic>>> postData(
  //     String linkurl, Map<String, dynamic> data) async {
  //   if (await checkInternet()) {
  //     var response = await http.post(Uri.parse(linkurl), body: data);
  //     print(response.statusCode);

  //     if (response.statusCode == 200 || response.statusCode == 201) {
  //       Map<String, dynamic> responsebody = jsonDecode(response.body);
  //       print(responsebody);
  //       return Right(responsebody);
  //     } else {
  //       return const Left(StatusRequest.serverfailure);
  //     }
  //   } else {
  //     return const Left(StatusRequest.offlinefailure);
  //   }
  // }

//   Future<Either<StatusRequest, Map<String, dynamic>>> postData(String linkurl, Map<String, dynamic> data) async {
//   try {
//     if (await checkInternet()) {
//       var response = await http.post(Uri.parse(linkurl), body: data);
//       print(response.statusCode);

//       if (response.statusCode == 200 || response.statusCode == 201) {
//         Map<String, dynamic> responseBody = jsonDecode(response.body);
//         print(responseBody);
//         return Right(responseBody);
//       } else {
//         // Handle server errors
//         return Left(StatusRequest.serverfailure);
//       }
//     } else {
//       // Handle network connectivity issues
//       return Left(StatusRequest.offlinefailure);
//     }
//   } catch (e) {
//     // Handle unexpected errors
//     print("Error occurred during HTTP request: $e");
//     return Left(StatusRequest.serverfailure);
//   }

  Future<Either<Failure, Map<String, dynamic>>> postData(
      String linkurl, Map<String, dynamic> data) async {
    try {
      if (await checkInternet()) {
        final dio = Dio();
        final response = await dio.post(linkurl, data: data);

        print(response.statusCode);

        if (response.statusCode == 200 || response.statusCode == 201) {
          final responseBody = response.data as Map<String, dynamic>;
          print(responseBody);
          return Right(responseBody);
        } else {
          // Handle server errors
          return Left(
              ServerFailure.fromResponse(response.statusCode, response.data));
        }
      } else {
        // Handle network connectivity issues
        return Left(ServerFailure('No Internet Connection'));
      }
    } on DioException catch (e) {
      // Handle Dio errors
      print("Error occurred during HTTP request: $e");
      return Left(ServerFailure.fromDioException(e));
    } catch (e) {
      // Handle unexpected errors
      print("Unexpected error occurred during HTTP request: $e");
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, Map<String, dynamic>>> getData(String linkurl) async {
    try {
      if (await checkInternet()) {
        final dio = Dio();
        final response = await dio.get(linkurl);

        print(response.statusCode);

        if (response.statusCode == 200) {
          final responseBody = response.data as Map<String, dynamic>;
          print(responseBody);
          return Right(responseBody);
        } else {
          // Handle server errors
          return Left(
              ServerFailure.fromResponse(response.statusCode, response.data));
        }
      } else {
        // Handle network connectivity issues
        return Left(ServerFailure('No Internet Connection'));
      }
    } on DioException catch (e) {
      // Handle Dio errors
      print("Error occurred during HTTP request: $e");
      return Left(ServerFailure.fromDioException(e));
    } catch (e) {
      // Handle unexpected errors
      print("Unexpected error occurred during HTTP request: $e");
      return Left(ServerFailure(e.toString()));
    }
  }

Future<Either<Failure, Map<String, dynamic>>> putDataWithFile(
      String linkurl, Map<String, dynamic> data, File file) async {
    try {
      if (await checkInternet()) {
        final dio = Dio();
        String fileName = basename(file.path);

        FormData formData = FormData.fromMap({
          ...data,
          "image": await MultipartFile.fromFile(file.path, filename: fileName),
        });

        final response = await dio.put(linkurl, data: formData);

        print(response.statusCode);

        if (response.statusCode == 200) {
          final responseBody = response.data as Map<String, dynamic>;
          print(responseBody);
          return Right(responseBody);
        } else {
          // Handle server errors
          return Left(
              ServerFailure.fromResponse(response.statusCode, response.data));
        }
      } else {
        // Handle network connectivity issues
        return Left(ServerFailure('No Internet Connection'));
      }
    } on DioException catch (e) {
      // Handle Dio errors
      print("Error occurred during HTTP request: $e");
      return Left(ServerFailure.fromDioException(e));
    } catch (e) {
      // Handle unexpected errors
      print("Unexpected error occurred during HTTP request: $e");
      return Left(ServerFailure(e.toString()));
    }
  }


  Future<Either<Failure, Map<String, dynamic>>> postDataWithFile(
      String linkurl, Map<String, dynamic> data, File file) async {
    try {
      if (await checkInternet()) {
        final dio = Dio();
        String fileName = basename(file.path);

        FormData formData = FormData.fromMap({
          ...data,
          "image": await MultipartFile.fromFile(file.path, filename: fileName),
        });

        final response = await dio.post(linkurl, data: formData);

        print("Response status code: ${response.statusCode}");
        print("Response data: ${response.data}");

        if (response.statusCode == 200 || response.statusCode == 201) {
          final responseBody = response.data as Map<String, dynamic>;
          print(responseBody);
          return Right(responseBody);
        } else {
          // Handle 
          print("Server Error: ${response.statusCode} ${response.data}");
          return Left(

            ServerFailure.fromResponse(response.statusCode, response.data));
        }
      } else {
        // Handle network connectivity issues
        return Left(ServerFailure('No Internet Connection'));
      }
    } on DioException catch (e) {
      // Handle Dio errors
      print("Error occurred during HTTP request: $e");
      print("Dio Error Response Data: ${e.response?.data}");
      return Left(ServerFailure.fromDioException(e));
    } catch (e) {
      // Handle unexpected errors
      print("Unexpected error occurred during HTTP request: $e");
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, Map<String, dynamic>>> putData(
      String linkurl, Map<String, dynamic> data) async {
    try {
      if (await checkInternet()) {
        final dio = Dio();

        final response = await dio.put(linkurl, data: data);

        print(response.statusCode);

        if (response.statusCode == 200) {
          final responseBody = response.data as Map<String, dynamic>;
          print(responseBody);
          return Right(responseBody);
        } else {
          // Handle server errors
          return Left(
              ServerFailure.fromResponse(response.statusCode, response.data));
        }
      } else {
        // Handle network connectivity issues
        return Left(ServerFailure('No Internet Connection'));
      }
    } on DioException catch (e) {
      // Handle Dio errors
      print("Error occurred during HTTP request: $e");
      return Left(ServerFailure.fromDioException(e));
    } catch (e) {
      // Handle unexpected errors
      print("Unexpected error occurred during HTTP request: $e");
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, Map<String, dynamic>>> deleteData(
      String linkurl, Map<String, dynamic> data) async {
    try {
      if (await checkInternet()) {
        final dio = Dio();
        final response = await dio.delete(linkurl, data: data);

        print(response.statusCode);

        if (response.statusCode == 200 || response.statusCode == 204) {
          final responseBody = response.data as Map<String, dynamic>;
          print(responseBody);
          return Right(responseBody);
        } else {
          // Handle server errors
          return Left(
              ServerFailure.fromResponse(response.statusCode, response.data));
        }
      } else {
        // Handle network connectivity issues
        return Left(ServerFailure('No Internet Connection'));
      }
    } on DioException catch (e) {
      // Handle Dio errors
      print("Error occurred during HTTP request: $e");
      return Left(ServerFailure.fromDioException(e));
    } catch (e) {
      // Handle unexpected errors
      print("Unexpected error occurred during HTTP request: $e");
      return Left(ServerFailure(e.toString()));
    }
  }



  Future<String> uploadFileToCloudinary(File file) async {
    final dio = Dio();
    final String uploadUrl = 'https://api.cloudinary.com/v1_1/dwcrlaw9a/image/upload'; // Replace with your Cloudinary upload URL

    FormData formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(file.path, filename: file.uri.pathSegments.last),
      'upload_preset': 'vdthxawq', // Replace with your Cloudinary upload preset
    });

    final response = await dio.post(uploadUrl, data: formData);

    if (response.statusCode == 200) {
      final data = response.data;
      print('Response data: $data'); // Print the entire response data
      print('Uploaded image URL: ${data['secure_url']}'); // Print the secure_url
      return data['secure_url']; // This is the URL of the uploaded image
    } else {
      throw Exception('Failed to upload file');
    }
  }


////////////////////////////////////////////////////////////////
///            Wael

//   Future<Either<Failure, Map<String, dynamic>>> addRequestWithImageOne(
//       String url, Map<String, dynamic> data, File? image, [String? namerequest]) async {
//     try {
//       if (await checkInternet()) {
//         final dio = Dio();

//         FormData formData = FormData.fromMap({
//           ...data,
//           if (image != null) namerequest ?? 'files': await MultipartFile.fromFile(
//             image.path,
//             filename: basename(image.path),
//           ),
//         });

//         final response = await dio.post(url, data: formData);

//         print(response.statusCode);

//         if (response.statusCode == 200 || response.statusCode == 201) {
//           final responseBody = response.data as Map<String, dynamic>;
//           print(responseBody);
//           return Right(responseBody);
//         } else {
//           // Handle server errors
//           return Left(
//               ServerFailure.fromResponse(response.statusCode, response.data));
//         }
//       } else {
//         // Handle network connectivity issues
//         return Left(ServerFailure('No Internet Connection'));
//       }
//     } on DioException catch (e) {
//       // Handle Dio errors
//       print("Error occurred during HTTP request: $e");
//       return Left(ServerFailure.fromDioException(e));
//     } catch (e) {
//       // Handle unexpected errors
//       print("Unexpected error occurred during HTTP request: $e");
//       return Left(ServerFailure(e.toString()));
//     }

    
//   }
}






