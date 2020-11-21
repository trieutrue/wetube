import React from 'react';
import VideoNavContainer from '../nav/video_nav/video_nav_container'

export default class VideoShow extends React.Component {
  componentDidMount() {
    this.props.fetchVideo(this.props.match.params.videoId)
  }

  render() {
    const { video, user } = this.props;
    return (
      <>
        <video src={video.videoUrl}></video>
        <VideoNavContainer video={video} user={user}/>
      </>
    )
  }
}