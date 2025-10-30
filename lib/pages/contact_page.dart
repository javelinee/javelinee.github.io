import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/contact_info.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final screenWidth = MediaQuery.of(context).size.width;
    final isWeb = screenWidth > 768;
    const contact = ContactInfo.personal;

    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: isWeb ? 64 : 24,
          vertical: isWeb ? 48 : 24,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Center(
              child: Column(
                children: [
                  Text(
                    'Get In Touch',
                    style: GoogleFonts.poppins(
                      fontSize: isWeb ? 48 : 32,
                      fontWeight: FontWeight.bold,
                      color: colorScheme.onSurface,
                    ),
                  ),
                  SizedBox(height: isWeb ? 24 : 16),
                  Text(
                    'Have a project in mind or want to collaborate? I\'d love to hear from you!',
                    style: GoogleFonts.poppins(
                      fontSize: isWeb ? 18 : 16,
                      color: colorScheme.onSurface.withOpacity(0.7),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            SizedBox(height: isWeb ? 64 : 40),

            // Main Content Layout
            isWeb
                ? Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Left Column - Contact Info & Social
                      Expanded(
                        flex: 1,
                        child: Column(
                          children: [
                            _buildContactInfoSection(context, contact, isWeb),
                            const SizedBox(height: 32),
                            _buildSocialLinksSection(context, contact),
                          ],
                        ),
                      ),
                      const SizedBox(width: 48),
                      // Right Column - Contact Form
                      Expanded(flex: 1, child: _buildContactForm(context)),
                    ],
                  )
                : Column(
                    children: [
                      _buildContactInfoSection(context, contact, isWeb),
                      const SizedBox(height: 24),
                      _buildSocialLinksSection(context, contact),
                      const SizedBox(height: 40),
                      _buildContactForm(context),
                    ],
                  ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactInfoSection(
    BuildContext context,
    ContactInfo contact,
    bool isWeb,
  ) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _buildContactCard(
                context,
                icon: Icons.email,
                title: 'Email',
                subtitle: contact.email,
                onTap: () => _sendEmail(contact.email),
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildContactCard(
                context,
                icon: Icons.chat,
                title: 'WhatsApp',
                subtitle: contact.whatsappNumber ?? 'Message me',
                onTap: () => _openWhatsApp(contact.whatsappNumber ?? ''),
                color: const Color(0xFF25D366),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildContactCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    required Color color,
  }) {
    return Card(
      elevation: 4,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, size: 32, color: color),
              ),
              const SizedBox(height: 16),
              Text(
                title,
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                subtitle,
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: Theme.of(
                    context,
                  ).colorScheme.onSurface.withOpacity(0.7),
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSocialLinksSection(BuildContext context, ContactInfo contact) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Connect with me',
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                if (contact.linkedinUrl != null)
                  _buildSocialButton(
                    context,
                    icon: Icons.business,
                    label: 'LinkedIn',
                    color: _getLinkedInColor(context),
                    onTap: () => _launchUrl(contact.linkedinUrl!),
                  ),
                if (contact.githubUrl != null)
                  _buildSocialButton(
                    context,
                    icon: Icons.code,
                    label: 'GitHub',
                    color: _getGitHubColor(context),
                    onTap: () => _launchUrl(contact.githubUrl!),
                  ),
                if (contact.websiteUrl != null)
                  _buildSocialButton(
                    context,
                    icon: Icons.web,
                    label: 'Website',
                    color: colorScheme.primary,
                    onTap: () => _launchUrl(contact.websiteUrl!),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Color _getGitHubColor(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return isDarkMode ? Colors.white : const Color(0xFF181717);
  }

  Color _getLinkedInColor(BuildContext context) {
    // LinkedIn blue is visible in both modes, but we can adjust if needed
    return const Color(0xFF0077B5);
  }

  Widget _buildSocialButton(
    BuildContext context, {
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, size: 28, color: color),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 12,
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
          ),
        ),
      ],
    );
  }

  Widget _buildContactForm(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Send me a message',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 20),

              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Your Name',
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Your Email',
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  if (!RegExp(
                    r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                  ).hasMatch(value)) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: _messageController,
                decoration: const InputDecoration(
                  labelText: 'Your Message',
                  prefixIcon: Icon(Icons.message),
                  border: OutlineInputBorder(),
                ),
                maxLines: 4,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your message';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _sendEmailFromForm,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: Text(
                    'Send Message',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _sendEmail(String email) async {
    final uri = Uri(
      scheme: 'mailto',
      path: email,
      query: 'subject=Hello from Portfolio App',
    );

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      _showErrorSnackBar('Could not open email client');
    }
  }

  Future<void> _sendEmailFromForm() async {
    if (_formKey.currentState!.validate()) {
      const contact = ContactInfo.personal;
      final subject = Uri.encodeComponent(
        'Message from ${_nameController.text}',
      );
      final body = Uri.encodeComponent(
        'Name: ${_nameController.text}\n'
        'Email: ${_emailController.text}\n\n'
        'Message:\n${_messageController.text}',
      );

      final uri = Uri(
        scheme: 'mailto',
        path: contact.email,
        query: 'subject=$subject&body=$body',
      );

      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
        _clearForm();
        _showSuccessSnackBar('Email client opened successfully!');
      } else {
        _showErrorSnackBar('Could not open email client');
      }
    }
  }

  Future<void> _openWhatsApp(String phoneNumber) async {
    final cleanNumber = phoneNumber.replaceAll(RegExp(r'[\s\-\(\)]'), '');
    final message = Uri.encodeComponent(
      'Hello! I found your portfolio and would like to connect.',
    );
    final uri = Uri.parse('https://wa.me/$cleanNumber?text=$message');

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      _showErrorSnackBar('Could not open WhatsApp');
    }
  }

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      _showErrorSnackBar('Could not launch $url');
    }
  }

  void _clearForm() {
    _nameController.clear();
    _emailController.clear();
    _messageController.clear();
  }

  void _showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.green),
    );
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
  }
}
