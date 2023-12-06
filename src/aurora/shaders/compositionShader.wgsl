@group(0) @binding(0) var textureSampOne: sampler;
@group(0) @binding(1) var textureOffscreen: texture_2d<f32>;
@group(0) @binding(2) var textureBloom: texture_2d<f32>;
@group(0) @binding(3) var textureLight: texture_2d<f32>;

struct VertexInput {
  @builtin(vertex_index) vi: u32,
  @builtin(instance_index) index: u32,



};
struct VertexOutput {
  @builtin(position) pos: vec4f,
  @location(1)  coords: vec2f,
  @location(2) @interpolate(flat) textureIndex: u32,
};
@vertex
fn vertexMain(props:VertexInput) -> VertexOutput{
var out:VertexOutput;
switch(props.vi){
    case 0: {
        out.coords = vec2f(0,1);
        out.pos = vec4f(-1,-1,0,1);}
    case 1: {
        out.coords = vec2f(1,1);
        out.pos = vec4f(1,-1,0,1);}
    case 2: {
        out.coords = vec2f(0,0);
        out.pos = vec4f(-1,1,0,1);}
    case 3: {
        out.coords = vec2f(0,0);
        out.pos = vec4f(-1,1,0,1);}
    case 4: {
        out.coords = vec2f(1,1);
        out.pos = vec4f(1,-1,0,1);}
    case 5: {
        out.coords = vec2f(1,0);
        out.pos = vec4f(1,1,0,1);}
    default: {
        out.coords = vec2f(0,1);
        out.pos = vec4f(1,0,0,1);}
}
out.textureIndex = props.index;
return out;
};
@fragment
fn fragmentMain(props:VertexOutput) -> @location(0) vec4f{
var out:vec4f;
let baseTexture = textureSample(textureOffscreen,textureSampOne,props.coords);
let bloomData = textureSample(textureBloom,textureSampOne,props.coords);
let lightData = textureSample(textureLight,textureSampOne,props.coords);

if(props.textureIndex == 1){
    out = baseTexture + bloomData;
}
else if(props.textureIndex == 2){
    out = baseTexture * lightData;
}
else{
    out = baseTexture;
};
return out;
}



