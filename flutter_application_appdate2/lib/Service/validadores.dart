
class Validadores {
 //correo Electrónico ---
  static String? validarCorreo(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'El correo electrónico es requerido.';
    }

    final regex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!regex.hasMatch(value.trim())) {
      return 'Por favor, introduce un correo electrónico válido.';
    }
    return null;
  }

  // contrasena
  static String? validarContrasena(String? value) {
    if (value == null || value.isEmpty) {
      return 'La contraseña es requerida.';
    }
    if (value.length < 8) {
      return 'Debe tener al menos 8 caracteres.';
    }
    if (!value.contains(RegExp(r'[A-Z]'))) {
      return 'Debe tener al menos una letra mayúscula (A-Z).';
    }
    if (!value.contains(RegExp(r'[a-z]'))) {
      return 'Debe tener al menos una letra minúscula (a-z).';
    }
    if (!value.contains(RegExp(r'[0-9]'))) {
      return 'Debe tener al menos un número (0-9).';
    }
    return null;
  }
  
  //Para los nombres
   static String? validarNombre(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'El nombre es requerido.';
    }
    final regex = RegExp(r'^[a-zA-Z\sñÑáéíóúÁÉÍÓÚ]+$');
    if (!regex.hasMatch(value)) {
      return 'El nombre solo puede contener letras y espacios.';
    }
    return null;
  }
}