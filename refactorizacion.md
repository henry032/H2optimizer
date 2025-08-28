lib/
├── main.dart                 # Punto de entrada de la app y configuración inicial.
│
├── app/                      # Configuración global de la app (rutas, tema, etc.).
│   ├── routes/
│   │   └── app_router.dart   # Configuración de la navegación.
│   └── theme/
│       └── app_theme.dart    # Estilos y tema de la aplicación.
│
├── core/                     # Código compartido que no es específico de una feature.
│   ├── constants/            # Constantes de la app (strings, URLs, etc.).
│   ├── services/             # Clases de servicio (ej: notificaciones).
│   ├── utils/                # Funciones de utilidad (ej: validadores, formateadores).
│   └── widgets/              # Widgets reutilizables en toda la app (ej: CustomButton).
│
├── data/                     # Capa de datos: modelos, repositorios y fuentes de datos.
│   ├── models/               # Modelos de datos (ej: user_model.dart).
│   ├── repositories/         # Contratos (interfaces) para obtener los datos.
│   │   └── auth_repository.dart
│   └── providers/            # Implementaciones concretas (Firebase, API REST).
│       └── firebase_auth_provider.dart
│
└── features/                 # Cada funcionalidad principal de la app tiene su propia carpeta.
    ├── auth/                 # Autenticación (Login, Registro, etc.).
    │   └── presentation/
    │       ├── cubit/        # Lógica de estado (opcional, pero recomendado).
    │       ├── screens/
    │       │   └── login_screen.dart
    │       └── widgets/
    │
    ├── home/                 # Pantalla principal con la barra de navegación.
    │   └── presentation/
    │       └── screens/
    │           └── home_screen.dart
    │
    ├── dashboard/            # Pestaña "Inicio" de la barra de navegación.
    │   └── presentation/
    │       ├── screens/
    │       │   └── dashboard_screen.dart
    │       └── widgets/
    │           ├── consumption_card.dart
    │           └── tip_of_the_day_card.dart
    │
    ├── statistics/           # Pestaña "Estadísticas".
    │   └── presentation/
    │       ├── cubit/
    │       ├── screens/
    │       │   ├── statistics_overview_screen.dart
    │       │   └── sensor_detail_screen.dart
    │       └── widgets/
    │           └── real_time_chart.dart # Aquí vivirá tu gráfico.
    │
    └── profile/              # Pestaña "Perfil".
        └── presentation/
            ├── cubit/
            ├── screens/
            │   ├── profile_screen.dart
            │   └── settings_screen.dart
            └── widgets/