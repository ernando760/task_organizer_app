# 📝 Lista de Tarefas Pessoais

Um aplicativo mobile de organização pessoal desenvolvido em Flutter, com foco em simplicidade, organização e boas práticas de arquitetura de software. Ele permite ao usuário criar, visualizar e gerenciar tarefas do dia.

---

## 📱 Funcionalidades

- Adicionar, atualizar e deletar tarefas
- Marcar tarefas como concluídas
- Persistência local com Isar
- Arquitetura limpa e modular

---

## 🧠 Arquitetura

Este projeto segue os princípios da **Clean Architecture**, organizando o código em camadas bem definidas para melhorar a manutenção, testabilidade e escalabilidade do app.

### 📂 Estrutura de pastas

```
lib/
└── src/
    ├── core/               # Temas, helpers, constantes
    ├── di/                 # Configuração da injeção de dependência
    ├── routes/             # Gerenciamento de rotas (GoRouter)
    └── tasks/
        ├── data/           # Fontes de dados (ex: Isar), modelos, repositórios
        ├── domain/         # Entidades, contratos de repositório e casos de uso
        └── presentation/   # Páginas, providers e widgets
```

---

## ⚙️ Tecnologias e Bibliotecas

- **Flutter**: SDK principal para desenvolvimento mobile.
- **ChangeNotifier**: Gerenciador de estado leve e direto.
- **GoRouter**: Gerenciamento de rotas de forma declarativa e escalável.
- **Isar**: Banco de dados local NoSQL eficiente.
- **Auto Injector**: Gerenciador de injeção de dependência baseado em reflexão.
- **Logger**: Logs para depuração.
- **Result Dart**: Tratamento funcional de erros e sucessos.
- **Equatable**: Facilita comparação de objetos.
- **UUID**: Geração de identificadores únicos.
- **Google Fonts**: Tipografias personalizadas.
- **Path Provider**: Para obter diretórios do sistema de arquivos.
- **Frontend Server Client**: Otimização de builds.
- **Mocktail**: Mocks para testes.

---

## 🧪 Como rodar o projeto

1. **Clone o repositório**

```bash
git clone https://github.com/ernando760/task_organizer_app
cd task_organizer_app
```

2. **Instale as dependências**

```bash
flutter pub get
```

3. **Execute o build do Isar (gera o `.g.dart`)**

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

4. **Execute o aplicativo**

```bash
flutter run
```

---

## 🧬 Decisões técnicas

### ✅ Clean Architecture

Escolhida para isolar regras de negócio e tornar a aplicação mais robusta e testável.

### ✅ ChangeNotifier

Simples e eficaz para esse projeto. Como não há múltiplos fluxos de estado complexos, foi suficiente para manter a clareza e performance.

### ✅ GoRouter

Gerenciamento de rotas com navegação declarativa e estrutura mais enxuta.

### ✅ Isar

Banco de dados local de alta performance, com suporte a índices, consultas eficientes e uso fácil com Flutter.

### ✅ Auto Injector

Simplifica a injeção de dependência, melhora a organização e evita tight coupling entre camadas.

---

## 🤖 Uso de IA

Utilizei IA (ChatGPT) para me auxiliar com:

- Estruturação da arquitetura e organização de pastas.
- Escrita de exemplos de código com boas práticas.
- Sugestões de nomes e separação de responsabilidades.
- Geração deste README.md.

Todos os códigos foram revisados e adaptados por mim para garantir consistência com meu estilo e entendimento.

---

## 🎥 Vídeo

<img src="assets/doc/demo.gif" width="300" heigth="200" />

---

## ✍️ Sobre o desenvolvimento

Esse projeto foi desenvolvido como parte de um processo seletivo. Optei por fazer um app simples, porém sólido, com foco em clareza de código e organização. Minhas prioridades foram:

- Separar responsabilidades.
- Escrever código limpo e bem comentado.
- Criar uma interface intuitiva e responsiva.
- Ter um fluxo de dados previsível.

---

## 👨‍💼 Autor

Feito com ❤️ por **Ernando**
[LinkedIn](https://www.linkedin.com/in/ernando-manoel/) | [GitHub](https://github.com/ernando760)
