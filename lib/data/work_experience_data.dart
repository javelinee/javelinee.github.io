import '../models/work_experience.dart';

class WorkExperienceData {
  static final List<WorkExperience> experiences = [
    WorkExperience(
      id: '1',
      position: 'Flutter Developer',
      company: 'Vantage Point Security',
      startDate: 'Aug 2025',
      endDate: 'Present',
      isPresent: true,
      description: 'Full-time • Singapore • Remote',
      achievements: [
        'Developing cross-platform websites using Flutter',
        'Working with Redis for data caching and management',
      ],
    ),
    WorkExperience(
      id: '2',
      position: 'Full Stack Engineer',
      company: 'PT Kecerdasan Buatan Solusi Bersama',
      startDate: 'Nov 2023',
      endDate: 'Jul 2025',
      description: 'Full-time • Jakarta, Indonesia • On-site • 1 yr 9 mos',
      achievements: [
        'Designed and developed frontend architecture using TypeScript and Tailwind CSS',
        'Built and maintained backend services with Golang, PostgreSQL, Docker, GCS and Redis',
        'Implemented comprehensive unit and integration testing to ensure high-quality code and system reliability',
      ],
    ),
    WorkExperience(
      id: '3',
      position: 'Jr. Mobile Engineer',
      company: 'VERIHUBS (YC S21)',
      startDate: 'Feb 2022',
      endDate: 'Oct 2023',
      description: 'Full-time • Jakarta, Indonesia • Hybrid • 1 yr 9 mos',
      achievements: [
        'Collaborated with product managers, product operations, UI/UX designers, and quality assurance to successfully develop SDKs variant through sprints',
        'Developed SDKs variant using Swift and Kotlin for Android and Objective-C for iOS development',
        'Collaborated with the mobile team to revitalize SDKs through clean architecture and clean code standards',
        'Created unit tests both in Android and iOS',
        'Contributed to the development of a script using Python for examining SDK logs',
      ],
    ),
    WorkExperience(
      id: '4',
      position: 'Frontend Engineer',
      company: 'VERIHUBS (YC S21)',
      startDate: 'Dec 2021',
      endDate: 'Jan 2022',
      description: 'Internship • Jakarta, Indonesia • 2 mos',
      achievements: [
        'Maintained client\'s external dashboard using Docker, PHP and Laravel',
        'Developed and maintained company\'s old website using Vue.js',
        'Collaborated with diverse team to develop and maintain client and admin dashboards using React.js',
      ],
    ),
    WorkExperience(
      id: '5',
      position: 'Mobile Engineer',
      company: 'VERIHUBS (YC S21)',
      startDate: 'Feb 2021',
      endDate: 'Nov 2021',
      description: 'Internship • Jakarta, Indonesia • 10 mos',
      achievements: [
        'Collaborated with product managers, product operations, UI/UX designers, and quality assurance to successfully develop SDKs variant through sprints',
        'Actively participated in sprint planning sessions to ensure successful execution of projects',
      ],
    ),
  ];

  static List<WorkExperience> getExperiences() {
    return experiences;
  }
}
