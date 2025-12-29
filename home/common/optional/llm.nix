{pkgs, ...}: {
  services.ollama = {
    enable = true;
    package = pkgs.ollama-rocm;
    acceleration = "rocm";
    environmentVariables = {
      HSA_OVERRIDE_GFX_VERSION = "10.3.0";
      # OLLAMA_DEBUG = "1";
      OLLAMA_GPU_LAYERS = "-1";
      OLLAMA_FLASH_ATTENTION = "true";
      OLLAMA_KV_CACHE_TYPE = "f16";
      OLLAMA_KEEP_ALIVE = "0";
    };
  };
}
