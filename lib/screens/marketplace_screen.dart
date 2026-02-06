import 'package:flutter/material.dart';

class MarketplaceScreen extends StatefulWidget {
  const MarketplaceScreen({super.key});

  @override
  State<MarketplaceScreen> createState() => _MarketplaceScreenState();
}

class _MarketplaceScreenState extends State<MarketplaceScreen> {
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _regionController = TextEditingController();
  String _selectedService = 'Todos';

  final List<String> _services = const [
    'Todos',
    'Pedreiro',
    'Servente',
    'Eletricista',
    'Encanador',
    'Pintor',
  ];

  final List<Professional> _professionals = const [
    Professional(
      name: 'Carlos Silva',
      service: 'Pedreiro',
      city: 'São Paulo',
      region: 'Zona Leste',
      availability: 'Disponível em 2 dias',
      rating: 4.8,
      completedJobs: 86,
      verified: true,
    ),
    Professional(
      name: 'Mariana Souza',
      service: 'Eletricista',
      city: 'São Paulo',
      region: 'Zona Sul',
      availability: 'Disponível hoje',
      rating: 4.9,
      completedJobs: 112,
      verified: true,
    ),
    Professional(
      name: 'João Ferreira',
      service: 'Servente',
      city: 'Guarulhos',
      region: 'Centro',
      availability: 'Disponível amanhã',
      rating: 4.6,
      completedJobs: 48,
      verified: true,
    ),
    Professional(
      name: 'Ana Lima',
      service: 'Pintor',
      city: 'Campinas',
      region: 'Barão Geraldo',
      availability: 'Disponível em 3 dias',
      rating: 4.7,
      completedJobs: 61,
      verified: true,
    ),
  ];

  @override
  void dispose() {
    _cityController.dispose();
    _regionController.dispose();
    super.dispose();
  }

  List<Professional> get _filteredProfessionals {
    return _professionals.where((professional) {
      final serviceMatch = _selectedService == 'Todos' ||
          professional.service.toLowerCase() == _selectedService.toLowerCase();
      final cityMatch = _cityController.text.trim().isEmpty ||
          professional.city
              .toLowerCase()
              .contains(_cityController.text.trim().toLowerCase());
      final regionMatch = _regionController.text.trim().isEmpty ||
          professional.region
              .toLowerCase()
              .contains(_regionController.text.trim().toLowerCase());

      return serviceMatch && cityMatch && regionMatch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('ObraConfiável'),
          centerTitle: true,
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Buscar profissionais'),
              Tab(text: 'Segurança'),
              Tab(text: 'Cadastro prestador'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildSearchTab(context),
            _buildSecurityTab(context),
            _buildProviderSignUpTab(context),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchTab(BuildContext context) {
    final filtered = _filteredProfessionals;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Encontre pedreiros, serventes e eletricistas por cidade ou região',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  initialValue: _selectedService,
                  decoration: const InputDecoration(
                    labelText: 'Tipo de serviço',
                    border: OutlineInputBorder(),
                  ),
                  items: _services
                      .map(
                        (service) => DropdownMenuItem(
                          value: service,
                          child: Text(service),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedService = value ?? 'Todos';
                    });
                  },
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _cityController,
                  decoration: const InputDecoration(
                    labelText: 'Cidade',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.location_city),
                  ),
                  onChanged: (_) => setState(() {}),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _regionController,
                  decoration: const InputDecoration(
                    labelText: 'Região/Bairro',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.map_outlined),
                  ),
                  onChanged: (_) => setState(() {}),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        Text('Resultados (${filtered.length})',
            style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 8),
        ...filtered.map((professional) => _ProfessionalCard(
              professional: professional,
              onHirePressed: () => _showContractFlow(context, professional),
            )),
      ],
    );
  }

  Widget _buildSecurityTab(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: const [
        _SecurityStepCard(
          step: '1',
          title: 'Cadastro com identidade completa',
          description:
              'Prestadores passam por validação de identidade com CPF, documento com foto e comprovante de residência.',
          icon: Icons.badge_outlined,
        ),
        _SecurityStepCard(
          step: '2',
          title: 'Contrato digital dentro da plataforma',
          description:
              'Cliente e prestador definem escopo, prazo e valor. O contrato fica registrado no histórico da plataforma.',
          icon: Icons.description_outlined,
        ),
        _SecurityStepCard(
          step: '3',
          title: 'Assinatura GOV para ambas as partes',
          description:
              'As partes assinam usando integração GOV para aumentar a confiabilidade e reduzir fraude.',
          icon: Icons.verified_user_outlined,
        ),
        _SecurityStepCard(
          step: '4',
          title: 'Pagamento protegido (escrow)',
          description:
              'O cliente paga pela plataforma e o valor fica protegido. A liberação acontece após confirmação de conclusão do serviço.',
          icon: Icons.lock_clock_outlined,
        ),
      ],
    );
  }

  Widget _buildProviderSignUpTab(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(
          'Pré-cadastro do prestador',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(height: 8),
        Text(
          'Fluxo inicial para web MVP: dados de contato, identidade e área de atuação.',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(height: 16),
        const _SimpleField(label: 'Nome completo'),
        const SizedBox(height: 12),
        const _SimpleField(label: 'Telefone (com WhatsApp)'),
        const SizedBox(height: 12),
        const _SimpleField(label: 'E-mail'),
        const SizedBox(height: 12),
        const _SimpleField(label: 'CPF'),
        const SizedBox(height: 12),
        const _SimpleField(label: 'Cidade e região de atendimento'),
        const SizedBox(height: 12),
        const _SimpleField(label: 'Número do documento de identidade (RG/CNH)'),
        const SizedBox(height: 12),
        FilledButton.icon(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                  'Pré-cadastro enviado! Próximo passo: upload de documentos e validação de identidade.',
                ),
              ),
            );
          },
          icon: const Icon(Icons.app_registration_outlined),
          label: const Text('Enviar pré-cadastro'),
        ),
      ],
    );
  }

  void _showContractFlow(BuildContext context, Professional professional) {
    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Contratar ${professional.name}'),
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Fluxo sugerido para contratação segura:'),
              SizedBox(height: 12),
              Text('• Definir escopo e valor do serviço.'),
              Text('• Gerar contrato digital.'),
              Text('• Coletar assinatura GOV de cliente e prestador.'),
              Text('• Receber pagamento protegido na plataforma.'),
              Text('• Liberar pagamento ao concluir serviço.'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Fechar'),
            ),
            FilledButton(
              onPressed: () {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Fluxo de contratação iniciado (MVP).'),
                  ),
                );
              },
              child: const Text('Iniciar contratação'),
            ),
          ],
        );
      },
    );
  }
}

class _SimpleField extends StatelessWidget {
  const _SimpleField({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
    );
  }
}

class _ProfessionalCard extends StatelessWidget {
  const _ProfessionalCard({required this.professional, required this.onHirePressed});

  final Professional professional;
  final VoidCallback onHirePressed;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    professional.name,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                if (professional.verified)
                  Chip(
                    avatar: const Icon(Icons.verified, size: 16),
                    label: const Text('Verificado'),
                    visualDensity: VisualDensity.compact,
                  ),
              ],
            ),
            const SizedBox(height: 6),
            Text('${professional.service} • ${professional.city} - ${professional.region}'),
            const SizedBox(height: 4),
            Text('Disponibilidade: ${professional.availability}'),
            Text('Avaliação: ${professional.rating} • ${professional.completedJobs} serviços concluídos'),
            const SizedBox(height: 10),
            FilledButton.icon(
              onPressed: onHirePressed,
              icon: const Icon(Icons.handshake_outlined),
              label: const Text('Contratar com segurança'),
            ),
          ],
        ),
      ),
    );
  }
}

class _SecurityStepCard extends StatelessWidget {
  const _SecurityStepCard({
    required this.step,
    required this.title,
    required this.description,
    required this.icon,
  });

  final String step;
  final String title;
  final String description;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        leading: CircleAvatar(child: Text(step)),
        title: Text(title),
        subtitle: Text(description),
        trailing: Icon(icon),
      ),
    );
  }
}

class Professional {
  const Professional({
    required this.name,
    required this.service,
    required this.city,
    required this.region,
    required this.availability,
    required this.rating,
    required this.completedJobs,
    required this.verified,
  });

  final String name;
  final String service;
  final String city;
  final String region;
  final String availability;
  final double rating;
  final int completedJobs;
  final bool verified;
}
