#version 310 es

struct a2v_cube
{
    vec3 inputPosition;
    vec3 inputUVW;
};

struct cube_vert_output
{
    vec4 pos;
    vec3 uvw;
};

struct Light
{
    float lightIntensity;
    uint lightType;
    int lightCastShadow;
    int lightShadowMapIndex;
    uint lightAngleAttenCurveType;
    uint lightDistAttenCurveType;
    vec2 lightSize;
    uvec4 lightGuid;
    vec4 lightPosition;
    vec4 lightColor;
    vec4 lightDirection;
    vec4 lightDistAttenCurveParams[2];
    vec4 lightAngleAttenCurveParams[2];
    mat4 lightVP;
    vec4 padding[2];
};

layout(location = 0) in vec3 a_inputPosition;
layout(location = 1) in vec3 a_inputUVW;
layout(location = 0) out vec3 _entryPointOutput_uvw;

cube_vert_output _passthrough_cube_vert_main(a2v_cube a)
{
    cube_vert_output o;
    o.pos = vec4(a.inputPosition, 1.0);
    o.uvw = a.inputUVW;
    return o;
}

void main()
{
    a2v_cube a;
    a.inputPosition = a_inputPosition;
    a.inputUVW = a_inputUVW;
    a2v_cube param = a;
    cube_vert_output flattenTemp = _passthrough_cube_vert_main(param);
    gl_Position = flattenTemp.pos;
    _entryPointOutput_uvw = flattenTemp.uvw;
}

