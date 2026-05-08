package api;

import cors.CorsFilter;
import jakarta.ws.rs.ApplicationPath;
import jakarta.ws.rs.core.Application;
import java.util.HashSet;
import java.util.Set;
import jwt.JwtFilter;
import resources.IncidenteResource;
import resources.LoginResource;
import resources.MonitorResource;
import resources.ReoResource;
import resources.VisitaResource;
import resources.VisitanteResource;

@ApplicationPath("/api")
public class ApplicationConfig extends Application {
    // Al dejar la clase vacía, Jakarta EE activa el "Automatic Scanning".
    // Esto buscará automáticamente LoginResource, ReoResource, JwtFilter, etc.
}