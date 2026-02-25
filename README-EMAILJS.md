# Activer l'envoi d'emails (GitHub Pages) — EmailJS

Ton portfolio est statique (GitHub Pages), donc il ne peut pas envoyer de mails via PHP/serveur.

✅ Solution : **EmailJS** (envoi réel depuis le front).

## 1) Créer le compte
- Va sur EmailJS et crée un compte
- Ajoute un service email (Gmail, Outlook, etc.)

## 2) Créer un template
Dans EmailJS → Templates → New template.

Variables conseillées dans le template (elles sont déjà prévues dans `email.js`) :
- `{{from_name}}`
- `{{reply_to}}`
- `{{message}}`
- (optionnel) `{{to_email}}`

Exemple de contenu :
- Subject: `Nouveau message portfolio - {{from_name}}`
- Body:
  - Nom: `{{from_name}}`
  - Email: `{{reply_to}}`
  - Message: `{{message}}`

## 3) Renseigner les IDs dans `email.js`
Ouvre `email.js` et remplace :
- `YOUR_EMAILJS_PUBLIC_KEY`
- `YOUR_EMAILJS_SERVICE_ID`
- `YOUR_EMAILJS_TEMPLATE_ID`

## 4) Mettre en ligne
Push le projet sur GitHub puis active GitHub Pages.

## Fallback
Si tu ne remplis pas les IDs, le formulaire ouvre la messagerie via `mailto:` (ça marche quand même, mais ce n'est pas automatique).
