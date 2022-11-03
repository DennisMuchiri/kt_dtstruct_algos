/**
  *  We also have to handle all our API responses on the UI thread.
  *  We would do that with an API response class, not a model this time around.
*
 *   We expose all those HTTP errors and exceptions to our UI through a generic class
  *  that encloses both the network status and the data coming from the API.
 */

class ApiResponse<T> {
  Status status;

  T data;

  String message;

  ApiResponse.loading(this.message): status = Status.LOADING;

  ApiResponse.completed(this.data) : status = Status.COMPLETED;

  ApiResponse.error(this.message) : status = Status.ERROR;

  @override
  String toString() {
    return "Status : $status \n Message : $message \n Data $data";
  }
}

enum Status{LOADING,COMPLETED,ERROR}