class Employee {
  int? id;
  String? initials;
  String firstName;
  String? middleName;
  String lastName;
  String telephone;
  dynamic dateOfBirth;
  int gender;
  int? departmentId;
  String? code;
  String? idNumber;
  String? nssfNumber;
  String? tinNumber;
  dynamic height;
  String? bloodGroup;
  String personalEmail;
  String? permanentAddress;
  String? presentAddress;
  bool? isAddressSame;
  String? officeNumber;
  String? mobileNumber;
  int userId;
  int? salutationId;
  int? maritalStatusId;
  String? avatar;
  String token;
  String url;

  Employee({
    this.id,
    this.initials,
    required this.firstName,
    this.middleName,
    required this.lastName,
    required this.telephone,
    required this.dateOfBirth,
    required this.gender,
    this.departmentId,
    this.code,
    this.idNumber,
    this.nssfNumber,
    this.tinNumber,
    this.height,
    this.bloodGroup,
    required this.personalEmail,
    this.permanentAddress,
    this.presentAddress,
    this.isAddressSame,
    this.officeNumber,
    this.mobileNumber,
    required this.userId,
    this.salutationId,
    this.maritalStatusId,
    this.avatar,
    required this.token,
    required this.url,
  });

  factory Employee.fromJson(Map json) {
    return Employee(
      id: json['employee']["id"],
      initials: json['employee']["initials"],
      firstName: json['employee']["first_name"],
      middleName: json['employee']["middle_name"],
      lastName: json['employee']["last_name"],
      telephone: json['employee']["telephone"],
      dateOfBirth: json['employee']["date_of_birth"],
      gender: json['employee']["gender"],
      departmentId: json['employee']["department_id"],
      code: json['employee']["code"],
      idNumber: json['employee']["id_number"],
      nssfNumber: json['employee']["nssf_number"],
      tinNumber: json['employee']["tin_number"],
      height: json['employee']["height"],
      bloodGroup: json['employee']["blood_group"],
      personalEmail: json['employee']["personal_email"],
      permanentAddress: json['employee']["permanent_address"],
      presentAddress: json['employee']["present_address"],
      isAddressSame: json['employee']["is_address_same"] == 1 ? true : false,
      officeNumber: json['employee']["office_number"],
      mobileNumber: json['employee']["mobile_number"],
      userId: json['employee']["user_id"],
      salutationId: json['employee']["salutation_id"],
      maritalStatusId: json['employee']["marital_status_id"],
      avatar: json["avatar"],
      token: json["token"],
      url: json["url"],
    );
  }

  static toJson(Employee employee) {
    return {
      "id": employee.id,
      "initials": employee.initials,
      "first_name": employee.firstName,
      "middle_name": employee.middleName,
      "last_name": employee.lastName,
      "telephone": employee.telephone,
      "date_of_birth": employee.dateOfBirth,
      "gender": employee.gender,
      "department_id": employee.departmentId,
      "code": employee.code,
      "id_number": employee.idNumber,
      "nssf_number": employee.nssfNumber,
      "tin_number": employee.tinNumber,
      "height": employee.height,
      "blood_group": employee.bloodGroup,
      "personal_email": employee.personalEmail,
      "permanent_address": employee.permanentAddress,
      "present_address": employee.presentAddress,
      "is_address_same": employee.isAddressSame,
      "office_number": employee.officeNumber,
      "mobile_number": employee.mobileNumber,
      "user_id": employee.userId,
      "salutation_id": employee.salutationId,
      "marital_status_id": employee.maritalStatusId,
      "avatar": employee.avatar,
    };
  }
}