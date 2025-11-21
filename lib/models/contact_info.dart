class ContactInfo {
  final String name;
  final String title;
  final String email;
  final String? phoneNumber;
  final String? whatsappNumber;
  final String? linkedinUrl;
  final String? githubUrl;
  final String? websiteUrl;
  final String? location;
  final String bio;
  final String? shortBio;

  const ContactInfo({
    required this.name,
    required this.title,
    required this.email,
    this.phoneNumber,
    this.whatsappNumber,
    this.linkedinUrl,
    this.githubUrl,
    this.websiteUrl,
    this.location,
    required this.bio,
    this.shortBio,
  });

  // Static instance with your personal information
  static const ContactInfo personal = ContactInfo(
    name: 'Jesselyn Hartandi',
    title: 'Flutter Developer',
    email: 'jesselynhartandii@gmail.com',
    phoneNumber: '+6285173456067',
    whatsappNumber: '+6285173456067',
    linkedinUrl: 'https://id.linkedin.com/in/jesselyn-hartandi',
    githubUrl: 'https://github.com/javelinee',
    location: 'Jakarta, Indonesia',
    shortBio:
        'Software Engineer specializing in building scalable applications and solving complex technical challenges. Passionate about clean code, user experience, and innovative solutions.',
    bio:
        'Versatile Flutter Developer with 3+ years of professional experience spanning the entire software development ecosystem. Expertise in native mobile development (Java/Kotlin for Android, Swift/Objective-C for iOS), cross-platform solutions (Flutter, React Native), and modern frontend technologies (React, TypeScript, HTML). Strong backend proficiency with diverse tech stacks including Go, Laravel, Python, PostgreSQL, and Redis. Demonstrated ability to architect and deliver end-to-end solutions across multiple platforms while maintaining code excellence and scalable system design. Currently specializing in Flutter development while leveraging full-stack capabilities for comprehensive project delivery.',
  );

  ContactInfo copyWith({
    String? name,
    String? title,
    String? email,
    String? phoneNumber,
    String? whatsappNumber,
    String? linkedinUrl,
    String? githubUrl,
    String? websiteUrl,
    String? location,
    String? bio,
    String? shortBio,
  }) {
    return ContactInfo(
      name: name ?? this.name,
      title: title ?? this.title,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      whatsappNumber: whatsappNumber ?? this.whatsappNumber,
      linkedinUrl: linkedinUrl ?? this.linkedinUrl,
      githubUrl: githubUrl ?? this.githubUrl,
      websiteUrl: websiteUrl ?? this.websiteUrl,
      location: location ?? this.location,
      bio: bio ?? this.bio,
      shortBio: shortBio ?? this.shortBio,
    );
  }
}
