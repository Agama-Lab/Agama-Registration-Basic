[#ftl output_format="HTML"]
<!DOCTYPE html>
<html lang="en">
<head><meta charset="UTF-8"><title>User Registration</title></head>
<body><h2>Register</h2><form method="post" id="registrationForm"><label for="uid">Username:</label><br><input type="text" id="uid" name="uid" required=""><br><br><label for="mail">Email:</label><br><input type="email" id="mail" name="mail" required=""><br><br><label for="userPassword">Password:</label><br><input type="password" id="userPassword" name="userPassword" required=""><br><br><label for="confirmPassword">Confirm Password:</label><br><input type="password" id="confirmPassword" name="confirmPassword" required=""><br><br><button type="submit">Register</button></form><div id="response"></div></body>

<script>
    const form = document.getElementById('registrationForm');
    const responseBox = document.getElementById('response');

    form.addEventListener('submit', async (e) => {
      e.preventDefault();

      const data = {
        uid: form.uid.value,
        mail: form.mail.value,
        userPassword: form.userPassword.value,
        confirmPassword: form.confirmPassword.value
      };

      try {
        const res = await fetch('https://<your-gluu-host>/flow/BasicRegistration', {
          method: 'POST',
          headers: { 'Content-Type': 'application/json' },
          body: JSON.stringify(data)
        });

        if (res.ok) {
          const result = await res.json();
          if (result.success === false) {
            responseBox.innerText = "Error: " + result.error;
          } else {
            responseBox.style.color = "green";
            responseBox.innerText = "Registration successful! Welcome " + result;
          }
        } else {
          const err = await res.text();
          responseBox.innerText = "Server error: " + err;
        }
      } catch (err) {
        responseBox.innerText = "Network error: " + err.message;
      }
    });
  </script>
</html>