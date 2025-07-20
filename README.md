# Sri Varahi Mess - Food Ordering System

A comprehensive real-time food ordering and management system built for Sri Varahi Mess, featuring separate menus for MR (Medical Representatives) and online orders with real-time updates and admin management.

## 🚀 Tech Stack

### Frontend
- **Framework**: Next.js 14 (App Router)
- **Language**: TypeScript
- **Styling**: Tailwind CSS
- **UI Components**: shadcn/ui
- **Icons**: Lucide React
- **Maps**: Leaflet.js + OpenStreetMap
- **Real-time**: Supabase Realtime
- **State Management**: React Hooks (useState, useEffect)
- **Notifications**: React Hot Toast
- **PWA**: Service Worker for Push Notifications

### Backend
- **Database**: Supabase (PostgreSQL)
- **Authentication**: Supabase Auth
- **Real-time**: Supabase Realtime subscriptions
- **API**: Next.js API Routes
- **Server Actions**: Next.js Server Actions
- **File Storage**: Supabase Storage (for images)

### Hosting & Deployment
- **Frontend Hosting**: Vercel
- **Database Hosting**: Supabase Cloud
- **CDN**: Vercel Edge Network
- **Domain**: Custom domain support
- **SSL**: Automatic HTTPS

### Development Tools
- **Package Manager**: npm/yarn
- **Code Quality**: ESLint, Prettier
- **Version Control**: Git
- **Environment**: Node.js 18+

## 🎯 Features

### Customer Features

#### 1. Online Order System
- **Order Placement**: Customers can place orders with name, phone, and address
- **Interactive Map**: Location selection using Leaflet.js maps
- **Menu Items**: 
  - Veg Meals (₹120)
  - Omlet (₹25)
  - Chapati (₹75)
  - Water Bottle (₹20)
- **Real-time Status**: Order status updates (pending → accepted/rejected)
- **Order Tracking**: Real-time order status monitoring

#### 2. MR (Medical Representative) Orders
- **Dedicated Portal**: Separate ordering system for MRs
- **Special Pricing**: Different pricing structure for MR orders
- **Quick Ordering**: Streamlined process for frequent customers
- **Real-time Updates**: Instant order status notifications

#### 3. Dine-in Attendance
- **Pre-arrival Notification**: Customers can notify before arriving
- **Time Selection**: Choose arrival time (5/10/15 mins or custom)
- **Party Size**: Specify number of people
- **Real-time Alerts**: Staff gets notified instantly

#### 4. MR Attendance System
- **Check-in System**: MRs can register their visit
- **Visit Tracking**: Track MR visits and timing
- **Real-time Notifications**: Admin gets instant alerts

### Admin Features

#### 1. Order Management
- **Real-time Dashboard**: Live view of all orders
- **Order Actions**: Accept/Reject orders with one click
- **Order History**: Complete order tracking and history
- **Multi-type Support**: Handle online, MR, and dine-in orders

#### 2. Menu Management
- **Dual Menu System**: Separate menus for MR and Online orders
- **Price Control**: Independent pricing for each menu type
- **Real-time Updates**: Menu changes reflect instantly
- **CRUD Operations**: Add, edit, delete menu items
- **Category Management**: Organize items by categories

#### 3. Attendance Management
- **Live Monitoring**: Real-time view of dine-in and MR attendance
- **Status Updates**: Mark attendance as served/completed
- **Time Tracking**: Monitor arrival and service times

#### 4. App Control
- **Service Toggle**: Enable/disable online ordering
- **Food Availability**: Control individual item availability
- **Real-time Sync**: Changes reflect across all platforms instantly

#### 5. Reports & Analytics
- **Daily Reports**: Comprehensive daily sales and order reports
- **Revenue Tracking**: Track income from different order types
- **Customer Analytics**: Monitor customer patterns and preferences
- **Export Options**: Download reports in various formats

### Real-time Features

#### 1. Live Updates
- **Order Status**: Instant status updates for customers
- **Admin Dashboard**: Real-time order notifications
- **Menu Changes**: Instant menu updates across all platforms
- **Attendance Alerts**: Live notifications for new arrivals

#### 2. Push Notifications
- **Web Push**: Browser notifications for admins
- **Service Worker**: Background notifications support
- **Order Alerts**: New order notifications with details
- **Status Updates**: Customer notifications for order changes

#### 3. Sound Notifications
- **Audio Alerts**: Sound notifications for new orders
- **Customizable**: Different sounds for different events
- **Admin Controls**: Enable/disable sound notifications

### Security & Compliance

#### 1. Food Safety Compliance
- **FSSAI License**: Display of license number (23625026000692)
- **Official Logo**: FSSAI certification logo display
- **Compliance Information**: Food safety standards adherence

#### 2. Data Security
- **Row Level Security**: Supabase RLS policies
- **Authentication**: Secure admin authentication
- **Data Validation**: Input validation and sanitization
- **HTTPS**: Secure data transmission

## 📱 User Interfaces

### Customer Interfaces
1. **Home Page** (`/`) - Main landing page with navigation
2. **Online Order** (`/order`) - Online food ordering
3. **MR Order** (`/mr-order`) - MR-specific ordering
4. **Dine-in** (`/dine`) - Dine-in attendance registration
5. **MR Attendance** (`/mr-attendance`) - MR visit registration
6. **Order Status** - Real-time order tracking pages

### Admin Interfaces
1. **Admin Dashboard** (`/admin`) - Main admin control panel
2. **Order Management** - Live order monitoring and management
3. **Menu Management** - Dual menu system management
4. **Attendance Management** - Dine-in and MR attendance tracking
5. **Reports** (`/report`) - Analytics and reporting
6. **App Settings** - System configuration and controls

## 🗄️ Database Schema

### Core Tables
\`\`\`sql
-- Online Orders
CREATE TABLE online_orders (
  id UUID PRIMARY KEY,
  customer_name TEXT,
  phone TEXT,
  address TEXT,
  location JSONB,
  items JSONB,
  total_amount DECIMAL,
  status TEXT DEFAULT 'pending',
  created_at TIMESTAMP DEFAULT NOW()
);

-- MR Orders
CREATE TABLE mr_orders (
  id UUID PRIMARY KEY,
  mr_name TEXT,
  phone TEXT,
  items JSONB,
  total_amount DECIMAL,
  status TEXT DEFAULT 'pending',
  created_at TIMESTAMP DEFAULT NOW()
);

-- Menu Tables
CREATE TABLE mr_menu (
  id UUID PRIMARY KEY,
  name TEXT,
  category TEXT,
  price NUMERIC,
  created_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE online_order_menu (
  id UUID PRIMARY KEY,
  name TEXT,
  category TEXT,
  price NUMERIC,
  created_at TIMESTAMP DEFAULT NOW()
);

-- Attendance Tables
CREATE TABLE dine_attendance (
  id UUID PRIMARY KEY,
  customer_name TEXT,
  phone TEXT,
  arrival_time TEXT,
  party_size INTEGER,
  status TEXT DEFAULT 'new',
  created_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE mr_attendance (
  id UUID PRIMARY KEY,
  mr_name TEXT,
  phone TEXT,
  visit_purpose TEXT,
  status TEXT DEFAULT 'new',
  created_at TIMESTAMP DEFAULT NOW()
);

-- App Configuration
CREATE TABLE app_status (
  id UUID PRIMARY KEY,
  online_order_active BOOLEAN DEFAULT true,
  created_at TIMESTAMP DEFAULT NOW()
);

-- Food Availability
CREATE TABLE food_status (
  id UUID PRIMARY KEY,
  item_name TEXT,
  is_available BOOLEAN DEFAULT true,
  created_at TIMESTAMP DEFAULT NOW()
);
\`\`\`

## 🚀 Getting Started

### Prerequisites
- Node.js 18 or higher
- npm or yarn package manager
- Supabase account
- Vercel account (for deployment)

### Installation

1. **Clone the repository**
\`\`\`bash
git clone <repository-url>
cd sri-varahi-mess
\`\`\`

2. **Install dependencies**
\`\`\`bash
npm install
# or
yarn install
\`\`\`

3. **Environment Setup**
Create a \`.env.local\` file in the root directory:
\`\`\`env
NEXT_PUBLIC_SUPABASE_URL=your_supabase_url
NEXT_PUBLIC_SUPABASE_ANON_KEY=your_supabase_anon_key
SUPABASE_SERVICE_ROLE_KEY=your_service_role_key
\`\`\`

4. **Database Setup**
- Create a new Supabase project
- Run the SQL scripts provided in the \`/sql\` directory
- Enable Realtime for all tables
- Configure Row Level Security policies

5. **Run the development server**
\`\`\`bash
npm run dev
# or
yarn dev
\`\`\`

6. **Open your browser**
Navigate to \`http://localhost:3000\`

### Deployment

#### Vercel Deployment
1. Connect your GitHub repository to Vercel
2. Add environment variables in Vercel dashboard
3. Deploy automatically on push to main branch

#### Supabase Configuration
1. Enable Realtime for all tables
2. Configure authentication settings
3. Set up Row Level Security policies
4. Configure storage buckets (if using file uploads)

## 📊 Performance Features

### Optimization
- **Next.js App Router**: Latest routing system for better performance
- **Server Components**: Reduced client-side JavaScript
- **Image Optimization**: Automatic image optimization
- **Code Splitting**: Automatic code splitting for faster loads
- **Caching**: Intelligent caching strategies

### Real-time Performance
- **Efficient Subscriptions**: Optimized Supabase subscriptions
- **Selective Updates**: Only update changed data
- **Connection Management**: Automatic reconnection handling
- **Memory Management**: Proper cleanup of subscriptions

## 🔧 Configuration

### Admin Settings
- **Service Hours**: Configure operating hours
- **Menu Availability**: Control item availability
- **Pricing**: Manage different pricing for MR and online orders
- **Notifications**: Configure push notification settings

### Customer Settings
- **Order Limits**: Set minimum/maximum order values
- **Delivery Areas**: Configure service areas
- **Payment Options**: Configure available payment methods

## 📱 Mobile Support

### Progressive Web App (PWA)
- **Offline Support**: Basic offline functionality
- **Push Notifications**: Mobile push notifications
- **App-like Experience**: Native app feel on mobile
- **Installation**: Can be installed on mobile devices

### Responsive Design
- **Mobile-first**: Designed for mobile devices
- **Touch-friendly**: Optimized for touch interactions
- **Fast Loading**: Optimized for mobile networks

## 🛠️ Development

### Code Structure
\`\`\`
src/
├── app/                 # Next.js App Router pages
├── components/          # Reusable React components
├── lib/                # Utility functions and configurations
├── hooks/              # Custom React hooks
├── types/              # TypeScript type definitions
└── styles/             # Global styles and Tailwind config
\`\`\`

### Key Components
- **Order Forms**: Customer order interfaces
- **Admin Dashboard**: Real-time admin interface
- **Menu Management**: Dynamic menu system
- **Real-time Hooks**: Supabase subscription hooks
- **Notification System**: Push notification management

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (\`git checkout -b feature/amazing-feature\`)
3. Commit your changes (\`git commit -m 'Add amazing feature'\`)
4. Push to the branch (\`git push origin feature/amazing-feature\`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 📞 Support

For support and queries:
- **Phone**: 810647829
- **FSSAI License**: 23625026000692

## 🙏 Acknowledgments

- **Supabase** for the excellent backend-as-a-service platform
- **Vercel** for seamless deployment and hosting
- **Next.js** team for the amazing React framework
- **Tailwind CSS** for the utility-first CSS framework
- **shadcn/ui** for the beautiful UI components

---

**Sri Varahi Mess** - Authentic South Indian Cuisine with Modern Technology
