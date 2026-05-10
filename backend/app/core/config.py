from pydantic_settings import BaseSettings
from pathlib import Path

PROJECT_ROOT = Path(__file__).resolve().parents[3]
ENV_FILE_PATH = PROJECT_ROOT / ".env"


class Settings(BaseSettings):
    PROJECT_NAME: str = "AI Literature Review System"
    VERSION: str = "2.0.0"
    API_V1_STR: str = "/api/v1"
    ENVIRONMENT: str = "development"  # Set to "production" in Railway

    # JWT Configuration
    SECRET_KEY: str = ""  # REQUIRED: Must be set via environment variable
    ALGORITHM: str = "HS256"
    ACCESS_TOKEN_EXPIRE_MINUTES: int = 1440  # 24 hours

    # Groq API key (REQUIRED: Set via environment variable)
    GROQ_API_KEY: str = ""

    # Database (defaults to SQLite; set DATABASE_URL in .env for PostgreSQL)
    DATABASE_URL: str = "sqlite:///./krr.db"

    # Redis (optional; for rate limiting in production)
    REDIS_URL: str = "redis://localhost:6379"

    # CORS (restricted in production; set via CORS_ORIGINS env var)
    CORS_ORIGINS: list[str] = ["http://localhost:5173", "http://localhost:3000"]

    # Upload settings
    MAX_UPLOAD_SIZE: int = 50 * 1024 * 1024  # 50MB
    UPLOAD_DIR: str = "uploads"

    class Config:
        env_file = str(ENV_FILE_PATH)
        extra = "ignore"

    def __init__(self, **data):
        super().__init__(**data)
        # Validate required fields in production
        if self.ENVIRONMENT == "production":
            if not self.SECRET_KEY or self.SECRET_KEY == "change-me-in-production":
                raise ValueError("SECRET_KEY must be set in production environment")
            if not self.GROQ_API_KEY:
                raise ValueError("GROQ_API_KEY must be set in production environment")


settings = Settings()
