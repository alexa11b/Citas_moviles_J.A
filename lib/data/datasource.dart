import 'package:flutter_application_appdate2/main.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseDataSource {
  Future<void> signUp({
    required String email,
    required String password,
    required Map<String, dynamic> profileData,
  }) async {
    final authResponse = await supabase.auth.signUp(email: email, password: password);
    if (authResponse.user != null) {
      await supabase.from('profiles').update(profileData).eq('id', authResponse.user!.id);
    }
  }

  Future<void> signIn({required String email, required String password}) {
    return supabase.auth.signInWithPassword(email: email, password: password);
  }

  Future<void> signOut() {
    return supabase.auth.signOut();
  }

  Future<Map<String, dynamic>> getProfile(String userId) {
    return supabase.from('profiles').select().eq('id', userId).single();
  }

  Stream<AuthState> get onAuthStateChange => supabase.auth.onAuthStateChange;
  Session? get currentSession => supabase.auth.currentSession;
  
  // ... (El resto de tus métodos para servicios, citas, etc. no cambian)
  Future<List<Map<String, dynamic>>> getServicios() => supabase.from('servicios').select('*, profiles(nombre)');
  Future<List<Map<String, dynamic>>> getServiciosPorProveedor(String proveedorId) => supabase.from('servicios').select().eq('proveedor_id', proveedorId);
  Future<void> addServicio(Map<String, dynamic> servicioData) => supabase.from('servicios').insert(servicioData);
  Future<void> deleteServicio(String servicioId) => supabase.from('servicios').delete().eq('id', servicioId);
  Future<List<Map<String, dynamic>>> getHorariosPorProveedor(String proveedorId) => supabase.from('horarios').select().eq('proveedor_id', proveedorId);
  Future<void> addHorario(Map<String, dynamic> horarioData) => supabase.from('horarios').insert(horarioData);
  Future<List<Map<String, dynamic>>> getCitasPorUsuario(String usuarioId) => supabase.from('citas').select('*, profiles!citas_cliente_id_fkey(nombre), servicios(nombre, duracion, precio)').or('cliente_id.eq.$usuarioId,proveedor_id.eq.$usuarioId');
  Future<void> addCita(Map<String, dynamic> citaData) => supabase.from('citas').insert(citaData);
  Future<void> cancelCita(String citaId) => supabase.from('citas').update({'estado': 'Cancelada'}).eq('id', citaId);
}