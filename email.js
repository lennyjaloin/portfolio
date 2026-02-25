const PUBLIC_KEY = "jsEV1HhIfV2cymmID";
const SERVICE_ID = "service_8ydod3c";
const TEMPLATE_ID = "template_39x999b";

emailjs.init(PUBLIC_KEY);

const form = document.getElementById("contactForm");

form.addEventListener("submit", function (e) {
  e.preventDefault();

  const templateParams = {
    nom: document.getElementById("nom").value,
    email: document.getElementById("email").value,
    message: document.getElementById("message").value,
  };

  emailjs.send(SERVICE_ID, TEMPLATE_ID, templateParams)
    .then(function () {
      alert("Message envoyé avec succès ✅");
      form.reset();
    }, function (error) {
      alert("Erreur lors de l'envoi ❌");
      console.log(error);
    });
});