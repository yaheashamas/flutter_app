  //return list from data base
    //get list user
      // Future getAllUsers() {
      //   UserApi userApi = new UserApi();
      //   Future<List<User>> usersFuture = userApi.getAllUser();
      //   return usersFuture;
      // }
    //build future builder
      // FutureBuilder<List<User>>(
      //       future: getAllUsers(),
      //       builder: (context, snapshot) {
      //         //the data not raede return circular
      //         if (snapshot.connectionState != ConnectionState.done) {
      //           return Center(child: CircularProgressIndicator());
      //         }
      //         List<User> users = snapshot.data ?? [];
      //         return ListView.builder(
      //             itemCount: users.length,
      //             itemBuilder: (context, index) {
      //               User user = users[index];
      //               return Text(user.email);
      //             });
      //       }));