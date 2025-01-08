# Utilisez l'image de base officielle d'Angular
FROM node:16 AS build

# Réglez le répertoire de travail
WORKDIR /app

# Copiez les dépendances du package et installez-les
COPY package*.json ./
RUN npm install

# Copiez les fichiers du projet Angular
COPY . .

# Construisez l'application Angular
RUN npm run build --prod

# Utilisez l'image Nginx comme serveur de production
FROM nginx:alpine

# Copiez le dossier dist produit par Angular
COPY --from=build /app/dist/bankati_frontend /usr/share/nginx/html

# Exposez le port Nginx par défaut
EXPOSE 80

# Commande pour démarrer Nginx
CMD ["nginx", "-g", "daemon off;"]
