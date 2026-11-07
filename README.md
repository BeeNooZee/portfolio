# Portfolio — Louis Dalet

Site vitrine personnel, **statique** (`site/index.html` + `site/assets/`).
En ligne : **https://portfolio.teladsiuol.com**

## Contenu
```
site/
  index.html          page unique (hero, expériences, projets, homelab, contact)
  assets/             photo.png, ld-black.png, ld-orange.png, CV-Louis-Dalet.pdf
deploy/deploy.sh      déploiement (sync site/ → /var/www/portfolio)
.github/workflows/deploy.yml   CI/CD : push sur main → déploiement auto
```

## Hébergement
- VM **192.168.1.117** (nginx), racine web `/var/www/portfolio`.
- Exposé en HTTPS via Nginx Proxy Manager → `portfolio.teladsiuol.com`.

## Déploiement (CI/CD)
Déploiement via un **runner GitHub Actions auto-hébergé** sur la VM (réseau privé,
pas d'exposition SSH publique).

- **Automatique** : chaque `git push` sur `main` lance `.github/workflows/deploy.yml`,
  qui exécute `deploy/deploy.sh` sur la VM (sync `site/` → `/var/www/portfolio`, reload nginx).
- **Manuel** : onglet *Actions → Déploiement → Run workflow*, ou en SSH `sudo bash deploy/deploy.sh`.

### Installer le runner (une fois)
Récupérer un jeton dans *repo → Settings → Actions → Runners → New self-hosted
runner*, puis sur la VM (en root) configurer le runner avec les étiquettes
`--labels portfolio --name portfolio-vm` et l'installer en service
(`./svc.sh install root && ./svc.sh start`).

Modifier le site = éditer `site/`, committer, pousser. C'est tout.
