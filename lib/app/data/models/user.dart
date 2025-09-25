class User {
  final String id;
  final String name;
  final String email;
  final String? phoneNumber;
  final String? photoUrl;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool emailVerified;
  final Map<String, dynamic>? metadata;

  User({
    required this.id,
    required this.name,
    required this.email,
    this.phoneNumber,
    this.photoUrl,
    required this.createdAt,
    required this.updatedAt,
    this.emailVerified = false,
    this.metadata,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? '',
      name: json['full_name'] ?? json['name'] ?? '',
      email: json['email'] ?? '',
      phoneNumber: json['phone'] ?? json['phoneNumber'],
      photoUrl: json['avatar_url'] ?? json['photoUrl'],
      createdAt: DateTime.tryParse(json['created_at'] ?? json['createdAt'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updated_at'] ?? json['updatedAt'] ?? '') ?? DateTime.now(),
      emailVerified: json['email_verified'] ?? false,
      metadata: json['metadata'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'full_name': name,
      'email': email,
      'phone': phoneNumber,
      'avatar_url': photoUrl,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'email_verified': emailVerified,
      'metadata': metadata,
    };
  }

  User copyWith({
    String? id,
    String? name,
    String? email,
    String? phoneNumber,
    String? photoUrl,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? emailVerified,
    Map<String, dynamic>? metadata,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      photoUrl: photoUrl ?? this.photoUrl,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      emailVerified: emailVerified ?? this.emailVerified,
      metadata: metadata ?? this.metadata,
    );
  }
}
