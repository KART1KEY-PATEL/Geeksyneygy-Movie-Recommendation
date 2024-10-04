class ValidationService {
  static Map<String, dynamic> validateEmail(String email) {
    String pattern = r'^[^@]+@[^@]+\.[^@]+$'; // Simple email regex pattern
    RegExp regex = RegExp(pattern);
    Map<String, dynamic> result = {"verified": false, "validatorText": ""};
    if (email.isEmpty) {
      result = {"verified": false, "validatorText": "Email cannot be empty"};

      return result;
    } else if (!regex.hasMatch(email)) {
      result = {"verified": false, "validatorText": "Enter a valid email"};
      return result;
    }
    result = {"verified": true, "validatorText": ""};
    return result;
  }

  static Map<String, dynamic> validatePassword(String passowrd) {
    Map<String, dynamic> result = {"verified": false, "validatorText": ""};

    if (passowrd.isEmpty) {
      result = {"verified": false, "validatorText": "Password cannot be empty"};
      return result;
    } else if (passowrd.length < 6) {
      result = {
        "verified": false,
        "validatorText": "Password must be atleast 6 characters"
      };

      return result;
    }

    result = {"verified": true, "validatorText": ""};
    return result;
  }

  static Map<String, dynamic> validateConfirmPassword(
      String password, String confirmPassword) {
    Map<String, dynamic> result = {"verified": false, "validatorText": ""};

    if (confirmPassword.isEmpty) {
      result = {
        "verified": false,
        "validatorText": "Confirm password cannot be empty"
      };
      return result;
    } else if (confirmPassword != password) {
      result = {"verified": false, "validatorText": "Passwords do not match"};
      return result;
    }
    result = {"verified": true, "validatorText": ""};
    return result;
  }

  static Map<String, dynamic> validateName(String name) {
    Map<String, dynamic> result = {"verified": false, "validatorText": ""};

    // Check if the name is empty
    if (name.isEmpty) {
      result = {"verified": false, "validatorText": "Name cannot be empty"};
      return result;
    }

    // Check if the name length is less than 3 characters
    if (name.length < 3) {
      result = {
        "verified": false,
        "validatorText": "Name must be at least 3 characters long"
      };
      return result;
    }

    // Check if the name contains only alphabets (no numbers or special characters)
    if (!RegExp(r"^[a-zA-Z\s]+$").hasMatch(name)) {
      result = {
        "verified": false,
        "validatorText": "Name must contain only letters"
      };
      return result;
    }

    // If all conditions are met, the name is valid
    result = {"verified": true, "validatorText": ""};
    return result;
  }

  static Map<String, dynamic> validatePhoneNumber(String phoneNumber) {
    Map<String, dynamic> result = {"verified": false, "validatorText": ""};

    // Remove any "+91" prefix if present
    if (phoneNumber.startsWith('+91')) {
      phoneNumber = phoneNumber.substring(3).trim();
    }

    // Check if the phone number is empty
    if (phoneNumber.isEmpty) {
      result = {
        "verified": false,
        "validatorText": "Phone number cannot be empty"
      };
      return result;
    }

    // Check if the phone number is exactly 10 digits long
    if (phoneNumber.length != 10) {
      result = {
        "verified": false,
        "validatorText": "Phone number must be exactly 10 digits long"
      };
      return result;
    }

    // Check if the phone number contains only digits
    if (!RegExp(r"^\d{10}$").hasMatch(phoneNumber)) {
      result = {
        "verified": false,
        "validatorText": "Phone number must contain only digits"
      };
      return result;
    }

    // If all conditions are met, the phone number is valid
    result = {"verified": true, "validatorText": ""};
    return result;
  }

  static Map<String, dynamic> validateAddress(String address) {
    Map<String, dynamic> result = {"verified": false, "validatorText": ""};

    // Check if the address is empty
    if (address.isEmpty) {
      result = {"verified": false, "validatorText": "Address cannot be empty"};
      return result;
    }

    // Check if the address is at least 10 characters long
    if (address.length < 10) {
      result = {
        "verified": false,
        "validatorText": "Address must be at least 10 characters long"
      };
      return result;
    }

    // If all conditions are met, the address is valid
    result = {"verified": true, "validatorText": ""};
    return result;
  }

  static Map<String, dynamic> validateGender(String gender) {
    Map<String, dynamic> result = {"verified": false, "validatorText": ""};

    // Check if the address is empty
    if (gender.isEmpty) {
      result = {"verified": false, "validatorText": "Gender cannot be empty"};
      return result;
    }

    // Check if the address is at least 10 characters long
    if (gender == "--Select Gender--") {
      result = {
        "verified": false,
        "validatorText": "Please select your gender",
      };
      return result;
    }

    // Check if the address contains only valid characters (letters, digits, spaces, commas, and periods)

    // If all conditions are met, the address is valid
    result = {"verified": true, "validatorText": ""};
    return result;
  }

  static Map<String, dynamic> validateDate(String date) {
    Map<String, dynamic> result = {"verified": false, "validatorText": ""};

    // Check if the address is empty
    if (date.isEmpty) {
      result = {"verified": false, "validatorText": "Date cannot be empty"};
      return result;
    }

    // Check if the address is at least 10 characters long
    if (date == "--Select Date--") {
      result = {
        "verified": false,
        "validatorText": "Please select your Date",
      };
      return result;
    }

    // Check if the address contains only valid characters (letters, digits, spaces, commas, and periods)

    // If all conditions are met, the address is valid
    result = {"verified": true, "validatorText": ""};
    return result;
  }
}
