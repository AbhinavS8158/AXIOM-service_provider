import 'package:flutter/material.dart';
import 'package:service_provider/model/propertycard_form_model.dart';

class PropertiesStreamSliver extends StatelessWidget {
  final Stream<List<PropertycardFormModel>> stream;
  final Widget Function(PropertycardFormModel property) itemBuilder;
  final String emptyMessage;

  const PropertiesStreamSliver({
    super.key,
    required this.stream,
    required this.itemBuilder,
    this.emptyMessage =
        'There are no rental properties available at the moment.',
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<PropertycardFormModel>>(
      stream: stream,
      builder: (context, snapshot) {
        // ---------------- LOADING ----------------
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SliverToBoxAdapter(
            child: Center(
              child: Padding(
                padding: EdgeInsets.all(50),
                child: Column(
                  children: [
                    CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Color(0xFFE0A76A),
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Loading properties...',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }

        // ---------------- ERROR ----------------
        if (snapshot.hasError) {
          return SliverToBoxAdapter(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.red.shade50,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Icon(
                        Icons.error_outline,
                        size: 48,
                        color: Colors.red.shade400,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Oops! Something went wrong',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }

        final properties = snapshot.data ?? [];

        // ---------------- EMPTY ----------------
        if (properties.isEmpty) {
          return SliverToBoxAdapter(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade50,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Icon(
                        Icons.home_outlined,
                        size: 48,
                        color: Colors.grey.shade400,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'No Properties Found',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      emptyMessage,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }

        // ---------------- LIST ----------------
        return SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: AnimatedContainer(
                    duration:
                        Duration(milliseconds: 300 + (index * 100)),
                    curve: Curves.easeOutBack,
                    child: itemBuilder(properties[index]),
                  ),
                );
              },
              childCount: properties.length,
            ),
          ),
        );
      },
    );
  }
}
