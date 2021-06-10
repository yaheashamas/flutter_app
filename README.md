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


// shared prefernses
// 1)-user
// 2)-token
// 3)-cities