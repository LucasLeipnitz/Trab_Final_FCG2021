#version 330 core

// Atributos de fragmentos recebidos como entrada ("in") pelo Fragment Shader.
// Neste exemplo, este atributo foi gerado pelo rasterizador como a
// interpolação da posição global e a normal de cada vértice, definidas em
// "shader_vertex.glsl" e "main.cpp".
in vec4 position_world;
in vec4 normal;

// Posição do vértice atual no sistema de coordenadas local do modelo.
in vec4 position_model;

// Coordenadas de textura obtidas do arquivo OBJ (se existirem!)
in vec2 texcoords;

// Matrizes computadas no código C++ e enviadas para a GPU
uniform mat4 model;
uniform mat4 view;
uniform mat4 projection;

// Identificador que define qual objeto está sendo desenhado no momento
uniform int object_id;


// Parâmetros da axis-aligned bounding box (AABB) do modelo
uniform vec4 bbox_min;
uniform vec4 bbox_max;

// Variáveis para acesso das imagens de textura
uniform sampler2D TextureImage0;
uniform sampler2D TextureImage1;
uniform sampler2D TextureImage2;
uniform sampler2D TextureImage3;
uniform sampler2D TextureImage4;
uniform sampler2D TextureImage5;
uniform sampler2D TextureImage6;
uniform sampler2D TextureImage7;
uniform sampler2D TextureImage8;

// O valor de saída ("out") de um Fragment Shader é a cor final do fragmento.
out vec3 color;

// Constantes
#define M_PI   3.14159265358979323846
#define M_PI_2 1.57079632679489661923
#define CARRO 0
#define PLANE 1
#define DESERT 2
#define MOUNTAIN 3
#define CITY 4
#define DESERT2 5
#define CEU 6
#define CAR2 7
#define BUILDING1 8

void main()
{
    // Obtemos a posição da câmera utilizando a inversa da matriz que define o
    // sistema de coordenadas da câmera.
    vec4 origin = vec4(0.0, 0.0, 0.0, 1.0);
    vec4 camera_position = inverse(view) * origin;

    // O fragmento atual é coberto por um ponto que percente à superfície de um
    // dos objetos virtuais da cena. Este ponto, p, possui uma posição no
    // sistema de coordenadas global (World coordinates). Esta posição é obtida
    // através da interpolação, feita pelo rasterizador, da posição de cada
    // vértice.
    vec4 p = position_world;

    // Normal do fragmento atual, interpolada pelo rasterizador a partir das
    // normais de cada vértice.
    vec4 n = normalize(normal);

    // Vetor que define o sentido da fonte de luz em relação ao ponto atual.
    vec4 l = normalize(vec4(1.0,1.0,0.0,0.0));

    // Vetor que define o sentido da câmera em relação ao ponto atual.
    vec4 v = normalize(camera_position - p);

    // Coordenadas de textura U e V
    float U = 0.0;
    float V = 0.0;

    if (object_id == CARRO)
    {
        // Coordenadas de textura do carro, computadas com projeção planar XY em COORDENADAS DO MODELO.
        vec4 bbox_center = (bbox_min + bbox_max) / 2.0;
        vec4 position_car = bbox_center + (position_model - bbox_center)/length(position_model - bbox_center);
        vec4 vector_car = position_car - bbox_center;

        float theta = atan(vector_car[0],vector_car[2]);
        float phi = asin(vector_car[1]);

        U = (theta + M_PI)/(2*M_PI);
        V = (phi + M_PI/2)/M_PI;

        // Obtemos a refletância difusa a partir da leitura da imagem TextureImage0
        vec3 Kd0 = texture(TextureImage1, vec2(U,V)).rgb;

        // Equação de Iluminação
        float lambert = max(0,dot(n,l));

        color = Kd0 * (lambert + 0.01);
    }else if (object_id == PLANE)
    {
        // Coordenadas de textura do plano, obtidas do arquivo OBJ.
        U = texcoords.x;
        V = texcoords.y;

        // Obtemos a refletância difusa a partir da leitura da imagem TextureImage0
        vec3 Kd0 = texture(TextureImage0, vec2(U,V)).rgb;

        // Equação de Iluminação
        float lambert = max(0,dot(n,l));

        color = Kd0 * (lambert + 0.01);
    }else if (object_id == DESERT)
    {
        // Coordenadas de textura do plano, obtidas do arquivo OBJ.
        U = texcoords.x;
        V = texcoords.y;

        // Obtemos a refletância difusa a partir da leitura da imagem TextureImage0
        vec3 Kd0 = texture(TextureImage2, vec2(U,V)).rgb;

        // Equação de Iluminação
        float lambert = max(0,dot(n,l));

        color = Kd0 * (lambert + 0.01);
    }else if (object_id == MOUNTAIN)
    {
        // Coordenadas de textura do plano, obtidas do arquivo OBJ.
        U = texcoords.x;
        V = texcoords.y;

        // Obtemos a refletância difusa a partir da leitura da imagem TextureImage0
        vec3 Kd0 = texture(TextureImage3, vec2(U,V)).rgb;

        color = Kd0;
    }else if (object_id == CITY)
    {
        // Coordenadas de textura do plano, obtidas do arquivo OBJ.
        U = texcoords.x;
        V = texcoords.y;

        // Obtemos a refletância difusa a partir da leitura da imagem TextureImage0
        vec3 Kd0 = texture(TextureImage4, vec2(U,V)).rgb;

        color = Kd0;
    }else if (object_id == DESERT2)
    {
        // Coordenadas de textura do plano, obtidas do arquivo OBJ.
        U = texcoords.x;
        V = texcoords.y;

        // Obtemos a refletância difusa a partir da leitura da imagem TextureImage0
        vec3 Kd0 = texture(TextureImage5, vec2(U,V)).rgb;

        color = Kd0;
    }else if (object_id == CEU)
    {
        // Coordenadas de textura do plano, obtidas do arquivo OBJ.
        U = texcoords.x;
        V = texcoords.y;

        // Obtemos a refletância difusa a partir da leitura da imagem TextureImage0
        vec3 Kd0 = texture(TextureImage6, vec2(U,V)).rgb;

        color = Kd0;
    }else if (object_id == CAR2)
    {
        // Coordenadas de textura do carro, computadas com projeção planar XY em COORDENADAS DO MODELO.
        vec4 bbox_center = (bbox_min + bbox_max) / 2.0;
        vec4 position_car = bbox_center + (position_model - bbox_center)/length(position_model - bbox_center);
        vec4 vector_car = position_car - bbox_center;

        float theta = atan(vector_car[0],vector_car[2]);
        float phi = asin(vector_car[1]);

        U = (theta + M_PI)/(2*M_PI);
        V = (phi + M_PI/2)/M_PI;

        // Obtemos a refletância difusa a partir da leitura da imagem TextureImage0
        vec3 Kd0 = texture(TextureImage7, vec2(U,V)).rgb;

        // Equação de Iluminação
        float lambert = max(0,dot(n,l));

        color = Kd0 * (lambert + 0.01);
    }else if (object_id == BUILDING1)
    {
        // Coordenadas de textura do plano, obtidas do arquivo OBJ.
        U = texcoords.x;
        V = texcoords.y;

        // Obtemos a refletância difusa a partir da leitura da imagem TextureImage0
        vec3 Kd0 = texture(TextureImage8, vec2(U,V)).rgb;

        // Equação de Iluminação
        float lambert = max(0,dot(n,l));

        color = Kd0 * (lambert + 0.01);
    }

    // Cor final com correção gamma, considerando monitor sRGB.
    // Veja https://en.wikipedia.org/w/index.php?title=Gamma_correction&oldid=751281772#Windows.2C_Mac.2C_sRGB_and_TV.2Fvideo_standard_gammas
    color = pow(color, vec3(1.0,1.0,1.0)/2.2);
}

